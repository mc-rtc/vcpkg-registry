vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/mc_rtc_data/releases/download/v1.0.4/mc_rtc_data-v1.0.4.tar.gz"
    FILENAME "mc_rtc_data-v1.0.4.tar.gz"
    SHA512 c0aa9d1a3d6e3ab94964827e5e46cf2b9248c17666772548b8f5950c4eacd0b724f862656a4180f81d2d876567596222aae9081d6e23097d3ba5631c015c6cfb
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.0.4
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
