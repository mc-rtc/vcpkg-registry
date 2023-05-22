include("${CMAKE_CURRENT_LIST_DIR}/vcpkg_find_fortran_for_subdirectory.cmake")

vcpkg_find_fortran_for_subdirectory(FORTRAN_CMAKE)
if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    set(MINGW_PATH mingw32)
else()
    set(MINGW_PATH mingw64)
endif()
set(MINGW_BIN "${vcpkg_find_fortran_for_subdirectory_MSYS_ROOT}/${MINGW_PATH}/bin")
set(MINGW_GFORTRAN "${MINGW_BIN}/gfortran.exe")

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/eigen-qld/releases/download/v1.2.3/eigen-qld-v1.2.3.tar.gz"
    FILENAME "eigen-qld-v1.2.3.tar.gz"
    SHA512 71857ea99621cf644cde5bc8b243e3f1a5ac4a819ec6f513b71f9cfb893f6f7a85ea7f0dd9dd2c46c5bcd7edd3ff305e3499ac860f6021ca02a7580cbf36366e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.2.3
    PATCHES
      fix-qld_fortran-import.patch
)

vcpkg_add_to_path("${MINGW_BIN}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
      -DBUILD_TESTING=OFF
      -DPYTHON_BINDING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
