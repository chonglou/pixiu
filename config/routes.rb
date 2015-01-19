require 'sidekiq/web'
Rails.application.routes.draw do


  get 'documents/index'

  #-------开始-----------
  scope '/:locale' do
    resources :products
    resources :orders
    resources :carts
    resources :comments
    resource :tags

    namespace :admin do
      get 'site/info'
      resources :notices
    end

    resources :documents

    get 'personal'=>'personal#index'

    get 'home' => 'home/index'

    get 'home/about_us'

    
  end

  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  root 'home#index'

end
