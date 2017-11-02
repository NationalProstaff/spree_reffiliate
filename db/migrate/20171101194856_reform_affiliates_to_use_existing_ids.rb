class ReformAffiliatesToUseExistingIds < ActiveRecord::Migration[5.0]
  def change
    remove_column :spree_affiliates, :email, :string
    remove_column :spree_affiliates, :activation_token, :string
    add_reference :spree_affiliates, :user, index: true
    add_column    :spree_affiliates, :created_at, :datetime, null: false
    add_column    :spree_affiliates, :deleted_at, :datetime
  end
end
