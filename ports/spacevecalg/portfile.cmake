vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/SpaceVecAlg/releases/download/v1.2.4/SpaceVecAlg-v1.2.4.tar.gz"
    FILENAME "SpaceVecAlg-v1.2.4.tar.gz"
    SHA512 5cd16be6f69f3e271792cb802a12b48ce59bea7708fc861db751e4b21c6131a3d6185732208efb8e6e9a3f6c2e69f9f40c6684b1fb5b96c276f321a4edadf0d5
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.2.4
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
