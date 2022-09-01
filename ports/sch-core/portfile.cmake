vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/sch-core/releases/download/v1.3.0/sch-core-v1.3.0.tar.gz"
    FILENAME "sch-core-v1.3.0.tar.gz"
    SHA512 786cec16366ecbafad2a1d09b3171985714131c32b06321b90159952a10fb993293c0bddc8a5bb8309c2dc78ce33b4fa0ffbe19d2be9f1190a00c3200db4824e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.3.0
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
