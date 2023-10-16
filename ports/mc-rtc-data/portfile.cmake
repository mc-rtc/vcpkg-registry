vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/mc_rtc_data/releases/download/v1.0.7/mc_rtc_data-v1.0.7.tar.gz"
    FILENAME "mc_rtc_data-v1.0.7.tar.gz"
    SHA512 36137d847b4a7500c470d388ea1cf5bf1f5e1f5a68db263ba8d4d0727b427b6a301d36b1af068df5fed4f479ce9b5548ec0ddc90c6dade07d2bdfdbdd68446c9
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.0.7
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
