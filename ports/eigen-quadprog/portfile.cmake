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
    URLS "https://github.com/jrl-umi3218/eigen-quadprog/releases/download/v1.1.1/eigen-quadprog-v1.1.1.tar.gz"
    FILENAME "eigen-quadprog-v1.1.1.tar.gz"
    SHA512 e1240ad9476de53734ee0d8a64e16a4306e5a71042a1da94c6803fa835dca1593a42bc39ab5058779a2b467302646b2c5304137c8ea0b025d02b5ae0bc2a7d44
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.1.1
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
