Deface::Override.new(
  virtual_path: "spree/admin/users/edit",
  name: "referral_fieldset",
  insert_after: "[data-hook='admin_user_api_key']",
  partial: "spree/admin/users/referral_fieldset"
)
