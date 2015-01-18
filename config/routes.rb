require 'sidekiq/web'
Rails.application.routes.draw do

  get 'home/index'

  scope '/:locale' do

  end

  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  root 'home#index'

end
