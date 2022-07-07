vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/loco-3d/ndcurves/releases/download/v1.1.2/ndcurves-1.1.2.tar.gz"
    URLS "https://github.com/loco-3d/ndcurves/releases/download/v1.1.4/ndcurves-1.1.4.tar.gz"
    FILENAME "ndcurves-1.1.4.tar.gz"
    SHA512 8667aeaca75c03675d5ca68aab64f2c33e3a4c1c507a19cb3db55b989b6421da981742ae3b0f4669368b6cd58604733b31963f3f8f749dbba1d1ad678fdc45e8
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.1.4
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING:BOOL=OFF
      -DBUILD_PYTHON_INTERFACE:BOOL=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/ndcurves)
vcpkg_fixup_pkgconfig()

file(WRITE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright "")
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
