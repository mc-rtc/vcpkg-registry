vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/RBDyn/releases/download/v1.5.2/RBDyn-v1.5.2.tar.gz"
    FILENAME "RBDyn-v1.5.2.tar.gz"
    SHA512 8683798f9569ebce9541b145c9d04f8b8b7f76b78099c146c498ae2959cd0066382ff503e21dd227205f35a4a951dd909b781163f972d9de7a704dad293bfdb1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.5.2
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
