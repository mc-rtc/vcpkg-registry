vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/state-observation/releases/download/v1.5.0/state-observation-v1.5.0.tar.gz"
    FILENAME "state-observation-v1.5.0.tar.gz"
    SHA512 05f69a29817aa7b9fe8086153d42962ae15ea40f90f2037b7c1f67ef5134568706a994db7a6fd31c445ee22bbf7ba1aa0be6e49542e980658208abd68380a357
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.5.0
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    NO_CHARSET_FLAG
    OPTIONS
      -DBUILD_TESTING=OFF
      -DBUILD_STATE_OBSERVATION_TOOLS=OFF
      -DPYTHON_BINDING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/state-observation)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
