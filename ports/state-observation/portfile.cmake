vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/state-observation/releases/download/v1.4.1/state-observation-v1.4.1.tar.gz"
    FILENAME "state-observation-v1.4.1.tar.gz"
    SHA512 8e2807b60e9c3c76e40dee684fa7ea35554350e402544ae9a3b0b194f433dc13281f06ef61c71c97578cd36b4c5b3f78dd2bbae578b5d123d9118f8ef089b850
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.4.1
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

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/state-observation)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
