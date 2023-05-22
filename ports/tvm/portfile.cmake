vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/tvm/releases/download/v0.9.0/tvm-v0.9.0.tar.gz"
    FILENAME "tvm-v0.9.0.tar.gz"
    SHA512 6f987bd6df7d9b69f259eaa0ac247612e21bf11c7c3174e5630bd2fdd8b5cefdd2894c245fb2cc391c51c01af8e23cf1b3649a53c18af2227162943b3f015e3a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 0.9.0
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
