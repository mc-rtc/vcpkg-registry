vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/Tasks/releases/download/v1.7.0/Tasks-v1.7.0.tar.gz"
    FILENAME "Tasks-v1.7.0.tar.gz"
    SHA512 f18cdc4c28af65e2bb4d4fed80e8306d92a2ac91c804afddb03fa4eb18db996019e5ff06f9b41210048dcdafd6fa7ef7c5af7b1097e7258c44b0c9b6c73d5de6
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.7.0
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

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/Tasks)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
