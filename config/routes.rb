Spree::Core::Engine.routes.draw do
  #get 'r/:code' => 'reffiliate#referral', as: 'referral'
  #get "promo/:path" => 'reffiliate#affiliate', as: 'affiliate'
  get 'account/referral_details' => 'users#referral_details'

  namespace :admin do
    resources :affiliates do
      resources :commissions do
        patch :pay, on: :member
      end
      get :transactions, on: :member
    end

    resources :commission_rules
  end
end
