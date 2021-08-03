vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/gergondet/hpp-spline/releases/download/v4.8.3/hpp-spline-4.8.3.tar.gz"
    FILENAME "hpp-spline-4.8.3.tar.gz"
    SHA512 83c52b503b2c8fad42f262c1b7c70692a0f0c4c042c3795e1ba5a1ff11a7788019d41e3e7e9ee24907ba0fd404cdc0652068ea579fdf144c605f9383d0d838f2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 4.8.3
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING:BOOL=OFF
      -DBUILD_PYTHON_INTERFACE:BOOL=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/hpp-spline)
vcpkg_fixup_pkgconfig()

file(WRITE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright "")
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
