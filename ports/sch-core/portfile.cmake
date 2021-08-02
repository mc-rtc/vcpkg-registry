vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/sch-core/releases/download/v1.2.0/sch-core-v1.2.0.tar.gz"
    FILENAME "sch-core-v1.2.0.tar.gz"
    SHA512 762548c021228a82fc3bc2ec1359dc946935db7015ec1c5d85a73a2e8d0b6095dfabc63d82ee773f0b24dc7eacd78b3de2dcca2658192f4b18bbd3a557c5a32c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.2.0
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING=OFF
      -DCMAKE_CXX_STANDARD=11
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
