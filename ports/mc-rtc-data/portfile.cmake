vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/mc_rtc_data/releases/download/v1.0.6/mc_rtc_data-v1.0.6.tar.gz"
    FILENAME "mc_rtc_data-v1.0.6.tar.gz"
    SHA512 8cbeb83a56fe7a7aed027ae81abfba3cadf407bfaf47c589f023d0df189c4e0f2d08fe1d5367f16500aec39d7739f437c56a74bd3c9c90a96af7fd5dd4664c7d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.0.6
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    NO_CHARSET_FLAG
    OPTIONS
      -DDISABLE_ROS:BOOL=ON
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(
  CONFIG_PATH lib/cmake/mc_env_description
  TARGET_PATH share/mc_env_description
  DO_NOT_DELETE_PARENT_CONFIG_PATH
)
vcpkg_fixup_cmake_targets(
  CONFIG_PATH lib/cmake/mc_int_obj_description
  TARGET_PATH share/mc_int_obj_description
  DO_NOT_DELETE_PARENT_CONFIG_PATH
)
vcpkg_fixup_cmake_targets(
  CONFIG_PATH lib/cmake/jvrc_description
  TARGET_PATH share/jvrc_description
)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
