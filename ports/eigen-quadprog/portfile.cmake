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
    URLS "https://github.com/jrl-umi3218/eigen-quadprog/releases/download/v1.1.2/eigen-quadprog-v1.1.2.tar.gz"
    FILENAME "eigen-quadprog-v1.1.2.tar.gz"
    SHA512 42e9f447f0f334c9975947ce7687138ab0dae059335dfd14702affbf64095db7c6415306ccaad25765d4e6a418daf615d2c8d2dd17c7afaf5e9ab5b1d4da70af
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.1.2
    PATCHES
      fix-quadprog_fortran-import.patch
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

file(INSTALL ${SOURCE_PATH}/COPYING.LESSER DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
