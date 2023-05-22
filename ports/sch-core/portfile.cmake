vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/sch-core/releases/download/v1.4.0/sch-core-v1.4.0.tar.gz"
    FILENAME "sch-core-v1.4.0.tar.gz"
    SHA512 97d4fc436d065a86944f3dd9e4c0f2bdad2a332c5dfd59ab19ea529577f4a80255b78b395ca1f0b08f8b37a92db6b4e29de3ec47f928ead685f66b851898057c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.4.0
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
