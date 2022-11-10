Rails.application.routes.draw do
  devise_for :users
 root to: "home#index"
  get "auth/twitter/callback", to: "omniauth_callbacks#twitter"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :twitter_accounts
  resources :tweets
end
