#!/usr/bin/env python3

import json
import os
import subprocess
import sys

if len(sys.argv) < 2:
    print("Usage: {} [port]".format(sys.argv[0]))
    sys.exit(1)

port = sys.argv[1]
registry_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "../"))
ports_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "../ports"))
versions_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "../versions"))

port_vcpkg_file = os.path.join(ports_dir, port, "vcpkg.json")
port_version_file = os.path.join(versions_dir, port[0] + "-", port + ".json")
baseline_file = os.path.join(versions_dir, "baseline.json")

port_vcpkg = json.load(open(port_vcpkg_file))
version = port_vcpkg["version-string"]
if "port-version" in port_vcpkg:
    port_version = port_vcpkg["port-version"]
else:
    port_version = 0

baseline = json.load(open(baseline_file))
baseline["default"][port]["baseline"] = version
baseline["default"][port]["port-version"] = port_version
json.dump(baseline, open(baseline_file, "w"), indent=2)

rev = (
    subprocess.check_output(
        "git rev-parse HEAD:ports/{}".format(port).split(), cwd=registry_dir
    )
    .decode(sys.stdout.encoding)
    .strip()
)
port_version_json = json.load(open(port_version_file))
port_version_json["versions"].insert(
    0, {"version": version, "port-version": port_version, "git-tree": rev}
)
json.dump(port_version_json, open(port_version_file, "w"), indent=2)
