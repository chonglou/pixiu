Rails.application.routes.draw do

  scope '/:locale' do

  end
  
  devise_for :users
  root 'home#index'

end
