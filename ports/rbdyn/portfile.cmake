vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/RBDyn/releases/download/v1.8.1/RBDyn-v1.8.1.tar.gz"
    FILENAME "RBDyn-v1.8.1.tar.gz"
    SHA512 c82119d044484ca8e462993e34ba877806fe32358bbe6efe0e072b7b746389490cfe32212346c6e691de436dca71dadb57161a5eeca060cfaf982bcda875fad0
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.8.1
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
