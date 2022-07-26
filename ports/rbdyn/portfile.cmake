vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/RBDyn/releases/download/v1.6.0/RBDyn-v1.6.0.tar.gz"
    FILENAME "RBDyn-v1.6.0.tar.gz"
    SHA512 fc3d7761cd0f15386326512b6787b6b85a32e8c31b1b1c99c3c7f1be63a6e494e61ad889c252cc97137ad6016f03fa4b355da1f580d6fb6826fc062a9467419a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.6.0
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    NO_CHARSET_FLAG
    OPTIONS
      -DBUILD_TESTING=OFF
      -DPYTHON_BINDING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/RBDyn)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

vcpkg_copy_tools(TOOL_NAMES urdf_yaml_converter AUTO_CLEAN)
