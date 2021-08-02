vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/RBDyn/releases/download/v1.4.0/RBDyn-v1.4.0.tar.gz"
    FILENAME "RBDyn-v1.4.0.tar.gz"
    SHA512 cb6bf1e810ff12627a80862406d394f7834fb9ec4fe74f1b56a329a501d84df2c182b926b35c71b51e8478c41d06d7e78d351f7922d7cd01866299ba99800fe6
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.4.0
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
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
