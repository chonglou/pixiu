Rails.application.routes.draw do
  scope '/:locale' do

  end

  root 'home#index'

end
