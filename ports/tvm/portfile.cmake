vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/tvm/releases/download/v0.9.2/tvm-v0.9.2.tar.gz"
    FILENAME "tvm-v0.9.2.tar.gz"
    SHA512 7796a521c897ef3685dc330ded7141028bfe8619eade6df5149c527254a248a4caa148028c6ec58d1b6b41f27b6ddfe1b4e9d7d9a99aa33da0ee8c2700536bd5
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 0.9.2
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    NO_CHARSET_FLAG
    OPTIONS
      -DBUILD_TESTING:BOOL=OFF
      -DTVM_WITH_QUADPROG:BOOL=ON
      -DTVM_WITH_ROBOT:BOOL=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/TVM)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
