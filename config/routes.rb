require 'sidekiq/web'
Rails.application.routes.draw do


  #-------开始-----------
  scope '/:locale' do

    resources :orders
    resources :carts
    resources :comments
    resources :tags

    #------------------------------------

    get 'documents/:name'=>'documents#show', as: :show_document_by_name
    get 'products/:uid'=>'products#show', as: :show_product_by_uid

    resources :tags, only:[:show]
    resources :notices, only:[:index]
    get 'users/:uid'=>'users#show', as: :show_user_by_uid

    get 'personal/contact'
    post 'personal/contact'
    patch 'personal/contact'

    namespace :admin do

      resources :users, only: [:index, :edit, :update]
      resources :notices, except:[:show]
      resources :documents, expect:[:show] do
        get 'tag'
        post 'tag'
      end
      resources :products, expect: [:show] do
        %w(status tag spec pack service).each do |a|
          get a
          post a
        end

        resources :samples, expect:[:show] do
          post 'logo'
        end
        resources :prices, expect:[:show]
      end
      resources :tags, expect: [:show, :new, :edit]

      %w(status seo).each { |a| get "site/#{a}" }

      %w(google baidu favicon clear).each { |a| post "site/#{a}" }

      %w(info).each do |a|
        get "site/#{a}"
        post "site/#{a}"
      end
    end



    get 'home' => 'home/index'
    get 'search' => 'search#index'
  end



  namespace :attachments do
    get 'controller'
    post 'controller'
    get 'manage'
    post 'manage'
  end


  get 'robots' => 'home#robots', constraints: {format: 'txt'}
  %w(sitemap rss).each { |a| get a => "home##{a}", constraints: {format: 'xml'} }
  %w(google baidu).each { |a| match a, to: "home##{a}", anchor: false, constraints: {format: 'html'}, via: [:get] }

  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, path:'accounts'

  root 'home#index'

end
