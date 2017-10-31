namespace :reffiliate do
  task generate: :environment do
    Spree.user_class.all.find_in_batches(:batch_size => 1000) do |group|
      group.each do |user|
        if user.referral.nil?
          user.create_referral
        end
      end
      puts "Referrals generated."
    end
  end
end
