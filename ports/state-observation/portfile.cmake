vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/state-observation/releases/download/v1.5.1/state-observation-v1.5.1.tar.gz"
    FILENAME "state-observation-v1.5.1.tar.gz"
    SHA512 31c2af261222714ff264804d86a1272c7f4436100d402f8b19ae19256bead5cb8b2f0f5cd160c4c20a24e499c863accb53d54f3d73a1b36e7e358818420d1b5c
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
      -DBUILD_STATE_OBSERVATION_TOOLS=OFF
      -DPYTHON_BINDING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/state-observation)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
