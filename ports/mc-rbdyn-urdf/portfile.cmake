vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/mc_rbdyn_urdf/releases/download/v1.1.0/mc_rbdyn_urdf-v1.1.0.tar.gz"
    FILENAME "mc_rbdyn_urdf-v1.1.0.tar.gz"
    SHA512 024421cba599ea44c6e2cd3a2268fd52345cbd12831461213262ab469af60b9b0f923fe41e942ef009d8bfd2b01c64327840d07dea725e25c4323b61a73e4c08
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.1.0
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    NO_CHARSET_FLAG
    OPTIONS
      -DBUILD_TESTING:BOOL=OFF
      -DPYTHON_BINDING:BOOL=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/mc_rbdyn_urdf TARGET_PATH share/mc_rbdyn_urdf)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
