#!/usr/bin/env python3

from github import Github

import requests

import hashlib
import json
import os
import re
import subprocess
import sys


def download_and_sha512(url):
    response = requests.get(url)
    return hashlib.sha512(response.content).hexdigest()


if len(sys.argv) < 2:
    print("Usage: {} [GitHub pat]".format(sys.argv[0]))
    sys.exit(1)

registry_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "../"))
ports_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "../ports"))
versions_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "../versions"))
repos_to_ports = {
    "jrl-umi3218/eigen-qld": "eigen-qld",
    'jrl-umi3218/eigen-quadprog': 'eigen-quadprog',
    'jrl-umi3218/mc_rtc_data': 'mc-rtc-data',
    'jrl-umi3218/mc_rtc': 'mc-rtc',
    'jrl-umi3218/RBDyn': 'rbdyn',
    'jrl-umi3218/sch-core': 'sch-core',
    'jrl-umi3218/SpaceVecAlg': 'spacevecalg',
    'jrl-umi3218/state-observation': 'state-observation',
    'jrl-umi3218/Tasks': 'tasks',
    'jrl-umi3218/tvm': 'tvm',
}

g = Github(sys.argv[1])

url = re.compile('.*? URLS "(.*?)"', re.M | re.S)
sha = re.compile(".*? SHA512 ([a-f0-9]*)", re.M | re.S)
version_re = re.compile(".*? REF ([.0-9]*)", re.M | re.S)

for stub, port in repos_to_ports.items():
    repo = g.get_repo(stub)
    release = repo.get_latest_release()
    tag = release.tag_name
    asset = [
        a.browser_download_url
        for a in release.get_assets()
        if a.browser_download_url.endswith(".tar.gz")
    ][0]
    # Take care of portfile update if needed
    portfile_file = os.path.join(ports_dir, port, "portfile.cmake")
    portfile_data = open(portfile_file).read()
    prev_asset = url.match(portfile_data).group(1)
    if prev_asset == asset:
        continue
    portfile_data = portfile_data.replace(prev_asset, asset)
    prev_file = prev_asset.split("/")[-1]
    new_file = asset.split("/")[-1]
    portfile_data = portfile_data.replace(prev_file, new_file)
    prev_sha = sha.match(portfile_data).group(1)
    new_sha = download_and_sha512(asset)
    portfile_data = portfile_data.replace(prev_sha, new_sha)
    version = tag.replace("v", "")
    prev_version = version_re.match(portfile_data).group(1)
    portfile_data = portfile_data.replace(prev_version, version)
    open(portfile_file, "w").write(portfile_data)
    # Take care of vcpkg.json update
    vcpkg_json_file = os.path.join(ports_dir, port, "vcpkg.json")
    vcpkg_json = json.load(open(vcpkg_json_file))
    if "port-version" in vcpkg_json:
        vcpkg_json["port-version"] = 0
    vcpkg_json["version-string"] = version
    json.dump(vcpkg_json, open(vcpkg_json_file, "w"), indent=2)
    # Commit once
    os.system(
        'cd {} && git add {} && git commit -m "[{}] Update to {}"'.format(
            ports_dir, port, port, version
        )
    )
    # Get rev-parse ouput
    rev = subprocess.check_output(
        "git rev-parse HEAD:ports/{}".format(port).split(), cwd=registry_dir
    ).decode(sys.stdout.encoding).strip()
    # Update baseline.json
    baseline_file = os.path.join(versions_dir, "baseline.json")
    baseline = json.load(open(baseline_file))
    baseline["default"][port]["baseline"] = version
    baseline["default"][port]["port-version"] = 0
    json.dump(baseline, open(baseline_file, "w"), indent=2)
    # Update port-version file
    port_version_file = os.path.join(versions_dir, port[0] + "-", port + ".json")
    port_version = json.load(open(port_version_file))
    port_version["versions"].insert(
        0, {"version": version, "port-version": 0, "git-tree": rev}
    )
    json.dump(port_version, open(port_version_file, "w"), indent=2)
    # Commit final thing
    os.system("cd {} && git add versions/ && git commit --amend --no-edit".format(registry_dir))
