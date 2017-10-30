class AddReferralAmountAndStatusToSpreeUser < ActiveRecord::Migration
  def change
    add_column Spree.user_class.table_name, :referral_credits, :decimal
    add_column Spree.user_class.table_name, :referrer_benefit_enabled, :boolean, default: true
  end
end
