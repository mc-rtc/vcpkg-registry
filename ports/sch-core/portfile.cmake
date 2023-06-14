vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/sch-core/releases/download/v1.4.2/sch-core-v1.4.2.tar.gz"
    FILENAME "sch-core-v1.4.2.tar.gz"
    SHA512 6d9580ec2868dc264571978b5b98ebc8a91a9b9bdccb9806ee57895521069ba594a23179a57361b60ad8a4dc87cd7a45f52e6b3a6ef20c22e1fb8569e5627fd7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.4.2
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
