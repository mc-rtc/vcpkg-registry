vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/SpaceVecAlg/releases/download/v1.2.5/SpaceVecAlg-v1.2.5.tar.gz"
    FILENAME "SpaceVecAlg-v1.2.5.tar.gz"
    SHA512 4303d54693801f5d9e136c1320b45b1929489f55d7affed39831ac2b8b0f7c022bdeffbf87e40f0fc6164389a187d0aae0636d5f97bcef70b9d47aae618ede65
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.2.5
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING=OFF
      -DPYTHON_BINDING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/SpaceVecAlg)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/spacevecalg RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
