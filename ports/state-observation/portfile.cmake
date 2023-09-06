vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/state-observation/releases/download/v1.5.2/state-observation-v1.5.2.tar.gz"
    FILENAME "state-observation-v1.5.2.tar.gz"
    SHA512 c3351a838d1ffe1569238a769c2c3c0c43e27fd56bb50d114e0d03ec2f4da7b46e325fc7c9f6c191136dfba8a0d6ed78014e341fd166cf6f3a8832b11271e0c7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.5.2
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
