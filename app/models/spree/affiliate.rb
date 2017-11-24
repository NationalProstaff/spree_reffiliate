module Spree
  class Affiliate < Spree::Base

    has_many :referred_records
    has_many :transactions, class_name: 'Spree::CommissionTransaction', dependent: :restrict_with_error
    has_many :commissions, class_name: 'Spree::Commission', dependent: :restrict_with_error
    has_many :affiliate_commission_rules, class_name: 'Spree::AffiliateCommissionRule', inverse_of: :affiliate, dependent: :destroy
    has_many :commission_rules, through: :affiliate_commission_rules, class_name: 'Spree::CommissionRule'
    belongs_to :user

    accepts_nested_attributes_for :affiliate_commission_rules, reject_if: :invalid_rule

    delegate :email, :to => :user

    validates :name, :path, :user_id, presence: true
    validates_associated :affiliate_commission_rules

    before_create :create_affiliate_user
    after_commit :send_activation_notification, on: :create

    self.whitelisted_ransackable_attributes =  %w[name user_id]

    def self.layout_options
      [
        ["No Layout", "false"],
        ["Spree Application Layout", 'spree/layouts/spree_application'],
        ["Custom Layout Path", nil]
      ]
    end

    def self.lookup_for_partial lookup_context, partial
      lookup_context.template_exists?(partial, ["spree/affiliates"], false)
    end

    def referred_users
      referred_records.includes(:user).collect(&:user).compact
    end

    def referred_orders
      referred_records.includes({user: :orders}).collect{|u| u.user.orders }.flatten.compact
    end

    def referred_count
      referred_records.count
    end

    def get_layout
      layout == 'false' ? false : layout
    end

    private

      def create_affiliate_user
        @user = Spree.user_class.find_or_initialize_by(id: user_id)
        user.save!
      end

      def send_activation_notification
        Spree::AffiliateMailer.activation_notification(user.id).deliver_later
      end

      def invalid_rule(attributes)
        !attributes[:id] && !attributes[:rate].present? && !attributes[:active].eql?('1')
      end

  end
end
