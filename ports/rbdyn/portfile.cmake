vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/RBDyn/releases/download/v1.5.1/RBDyn-v1.5.1.tar.gz"
    FILENAME "RBDyn-v1.5.1.tar.gz"
    SHA512 a72b0c7e4fa9e891ad62ff31958a67be5ca3fe13470dba07945513b863bf6d1a6d581bd7d6bb362dd5b50dad3fd1f1b5b2d7f0a6401535a50b8f266f5dad5897
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.5.1
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
