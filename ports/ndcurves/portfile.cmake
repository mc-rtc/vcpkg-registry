vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/loco-3d/ndcurves/releases/download/v1.1.2/ndcurves-1.1.2.tar.gz"
    FILENAME "ndcurves-1.1.2.tar.gz"
    SHA512 dd50ac642f8133c9cc19c1191b2393f8286d91be890bf7f090f7b21fde84e2f8c5cf36d0dcfee4596f758959f7421e8bbacdea6d711b107d4c317894562c8a72
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.1.2
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
