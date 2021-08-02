vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/Tasks/releases/download/v1.5.0/Tasks-v1.5.0.tar.gz"
    FILENAME "Tasks-v1.5.0.tar.gz"
    SHA512 b1869e8a609cc5ae8da5657c3f5b1c5898a5b59279c265c58a0be2c72461a9f2083828235bbbba89f7abaf9549993ceb26e037fdc38198248666613d689a8d66
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.5.0
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
