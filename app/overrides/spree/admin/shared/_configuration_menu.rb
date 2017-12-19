Deface::Override.new(
  virtual_path: "spree/admin/shared/sub_menu/_configuration",
  name: "admin_content_admin_configuration_menu_parser",
  original: "0c0b0a7a73f19b29c0375b0b14dfa34d8029d4c8",
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
  text: "<%= configurations_sidebar_menu_item Spree.t(:affiliates), admin_affiliates_path %>"
)
