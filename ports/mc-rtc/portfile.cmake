vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/mc_rtc/releases/download/v1.7.0/mc_rtc-v1.7.0.tar.gz"
    FILENAME "mc_rtc-v1.7.0.tar.gz"
    SHA512 72f5ccacdb03b329342d2da15f941476b286eec24d863fb62b181b7cfae77beba82fe8fc3e6a263c2422103d129542c082dfb73ba3e7f42004abbf11a5747633
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.7.0
    PATCHES
      spdlog-sink.patch
      mc-rtc-install-prefix.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    NO_CHARSET_FLAG
    OPTIONS
      -DBUILD_TESTING:BOOL=OFF
      -DDISABLE_ROS:BOOL=ON
      -DPYTHON_BINDING:BOOL=OFF
      -DMC_RTC_INSTALL_PREFIX=${CURRENT_INSTALLED_DIR}
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/mc_rtc TARGET_PATH share/mc_rtc)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

set(MC_RTC_TOOLS
  mc_bin_perf
  mc_bin_to_flat
  mc_bin_to_log
  mc_bin_utils
  mc_json_to_yaml
  mc_old_bin_to_flat
)

set(MC_RTC_PYTHON_TOOLS
  mc_log_ui
  mc_plot_logs
  mc_rtc_new_controller
  mc_rtc_new_fsm_controller
)

if(WIN32)
  foreach(tool_name ${MC_RTC_PYTHON_TOOLS})
    set(tool_path "${CURRENT_PACKAGES_DIR}/bin/${tool_name}.py")
    if(EXISTS ${tool_path})
      file(COPY ${tool_path} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/${PORT})
    endif()
  endforeach()
else()
  list(APPEND MC_RTC_TOOLS ${MC_RTC_PYTHON_TOOLS})
endif()

vcpkg_copy_tools(
  TOOL_NAMES
    ${MC_RTC_TOOLS}
  AUTO_CLEAN
)
