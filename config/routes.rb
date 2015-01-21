require 'sidekiq/web'
Rails.application.routes.draw do



  #-------开始-----------
  scope '/:locale' do

    resources :orders
    resources :carts
    resources :comments
    resources :tags

    #------------------------------------
    get 'documents/:name'=>'documents#show', as: :show_document
    get 'products/:uid'=>'products#show', as: :show_product
    get 'tags/:name'=>'tags#show', as: :show_tag


    get 'personal/contact'
    post 'personal/contact'
    patch 'personal/contact'

    namespace :admin do

      resources :users, only: [:index, :edit, :update]
      resources :notices, except:[:show]
      resources :documents, expect:[:show]
      resources :products, expect: [:show]
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
  end


  get 'robots' => 'home#robots', constraints: {format: 'txt'}
  get 'favicon' => 'home#favicon', constraints: {format: 'ico'}
  %w(sitemap rss).each { |a| get a => "home##{a}", constraints: {format: 'xml'} }
  %w(google baidu).each { |a| match a, to: "home##{a}", anchor: false, constraints: {format: 'html'}, via: [:get] }

  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users

  root 'home#index'

end
