vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/state-observation/releases/download/v1.5.3/state-observation-v1.5.3.tar.gz"
    FILENAME "state-observation-v1.5.3.tar.gz"
    SHA512 be9d9d71f483eee1052b5dc86dddf767c0319fb10b10d3df193a7be44e6602dd58d009ff7053dee2eae61b81712649d4a6b5485fb628c87817d328990bdae086
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.5.3
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
