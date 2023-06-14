vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/tvm/releases/download/v0.9.1/tvm-v0.9.1.tar.gz"
    FILENAME "tvm-v0.9.1.tar.gz"
    SHA512 d9b2e50fd4e1c491db3fb26e273ce0e74c5c247afdf4611d5adcfc8ed082d2480c8e6ad6776cb53a5989c618d735431ada3370f4a29ae722107daee47938b16a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 0.9.1
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
