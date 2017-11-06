Spree::CheckoutController.class_eval do
  before_action :set_affilate, only: :update
  after_action :clear_session, only: :update

  private
    def set_affilate
      if @order.payment? && session[:affiliate_id]
        @order.affiliate = Spree::Affiliate.find_by(user_id: session[:affiliate_id])
      end
    end

    def clear_session
      session[:affiliate_id] = nil if @order.completed?
    end
end
