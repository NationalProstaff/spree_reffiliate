module Spree
  class AffiliateMailer < BaseMailer
    def activation_instruction(id)
      @affiliate  = Spree::Affiliate.find_by(user_id: id)
      subject = Spree.t(:activation_instruction_subject, scope: :affiliate_mailer)
      mail(to: @affiliate.user.email, from: from_address, subject: subject)
    end
    def activation_notification(id)
      @affiliate  = Spree::Affiliate.find_by(user_id: id)
      subject = Spree.t(:activation_notification_subject, scope: :affiliate_mailer)
      mail(to: @affiliate.user.email, from: from_address, subject: subject)
    end
  end
end
