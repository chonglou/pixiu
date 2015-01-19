require 'sidekiq/web'
Rails.application.routes.draw do





  #-------开始-----------
  scope '/:locale' do
    resources :products
    resources :orders
    resources :carts
    resources :comments
    resource :tags

    namespace :admin do

      resources :users, only:[:index, :edit, :update]
      get 'site/status'
      %w(info).each do |a|
        get "site/#{a}"
        post "site/#{a}"
      end

      resources :notices
    end

    resources :documents

    get 'home' => 'home/index'

    get 'search' => 'search#index'
  end

  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  root 'home#index'

end
