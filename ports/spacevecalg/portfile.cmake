vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/SpaceVecAlg/releases/download/v1.2.0/SpaceVecAlg-v1.2.0.tar.gz"
    FILENAME "SpaceVecAlg-v1.2.0.tar.gz"
    SHA512 86eeeb39bb100e6501da3ce8d487964f184329b3ae9735a3e6c370d8046188e0f9332113efc975c2d670b8e5eb0b8d486ad191a823a9365010666bb8b5cbe7cb
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.2.0
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
