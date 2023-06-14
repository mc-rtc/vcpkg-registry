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
    URLS "https://github.com/jrl-umi3218/eigen-qld/releases/download/v1.2.4/eigen-qld-v1.2.4.tar.gz"
    FILENAME "eigen-qld-v1.2.4.tar.gz"
    SHA512 e12b5c39f6ca058c20584b54012b598219361d96a0bc652425db035a5fc7f9fa240ef50da4bc7a4701ba6d36f7e982e9afa0c21605f1fa7c180123d89da650a5
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.2.4
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
