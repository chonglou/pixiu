require 'sidekiq/web'
Rails.application.routes.draw do


  scope '/:locale' do
    resources :products
    resources :orders
    resources :carts
    resources :comments

    namespace :admin do
      get 'site/info'
      resources :notices
    end


    get 'home' => 'home/index'
  end

  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  root 'home#index'

end
