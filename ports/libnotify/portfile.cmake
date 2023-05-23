vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO GNOME/libnotify
    REF 0.8.2
    SHA512 0ea71ff28b4edfe78e704f7b4479f3a1288b7c93cd3d4da285312a7f9f6c8acdc92664493ce9f944a6ac0f80940da29b504111d9d1e2b0741dce8e1b38ba8bab
    HEAD_REF master
)

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -Ddocbook_docs=disabled
      -Dgtk_doc=false
      -Dintrospection=disabled
      -Dman=false
      -Dtests=false
    ADDITIONAL_BINARIES
      glib-genmarshal='${CURRENT_HOST_INSTALLED_DIR}/tools/glib/glib-genmarshal'
      glib-mkenums='${CURRENT_HOST_INSTALLED_DIR}/tools/glib/glib-mkenums'
)

vcpkg_install_meson()

vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
