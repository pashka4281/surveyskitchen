Surveyskitchen::Application.routes.draw do
  
  ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # match '/:locale' => 'home#index', :locale => /en|ru/, as: :locale_root
  root to: 'home#locale_redirect'
  scope "/:locale", :locale => /en|ru/ do
    get :tos, to: 'home#tos'
    # get :about, to: 'home#about'
    # get :plans, to: 'home#plans'
    # get :features, to: 'home#features'

    get  'login',    to: 'sessions#new'
    post 'login',    to: 'sessions#create'
    get  'register', to: 'users#new'
    post 'register', to: 'users#create'

    namespace :demo do
      put 's_builder', to: 'surveys#update'
      get 's_builder', to: 'surveys#builder'
      get 's_builder/preview', to: 'surveys#preview'
      get 's_builder/trashbox', to: 'surveys#trashbox'
      resources :survey_items, as: 'items', path: 's_builder/items' do
        delete :delete, as: :member
        post :copy, as: :member
        put :move, as: :member
      end
    end
    resources :buy_requests, only: [:new, :create]
    get 'know_more/:subject', to: 'home#know_more', as: :know_more
  end
  
  get 'logout',   to: 'sessions#destroy'
  get 'feed', to: 'feed#index'
  get :switch_locale, to: 'home#switch_locale'

  get :theme_preview, to: 'themes#theme_preview'

  resources :surveys do
    get :builder,   on: :member
    get :share,     on: :member
    get :trashbox,  on: :member
    get :report,    on: :member
    put :switch,    on: :member
    get :preview,   on: :member
    get :look, on: :member
    resources :survey_items, as: 'items', path: 'items' do
      delete :delete, as: :member
      post :copy, as: :member
      put :move, as: :member
    end
    resources :responses, only: [:show, :destroy, :index, :update]
    resources :themes
  end

  resources :quizes do
    get :builder,   on: :member
    resources :quiz_items, as: 'items', path: 'items'
  end

  namespace :s do
    get  ':token', to: 'surveys#show', as: :show_survey
    post ':token', to: 'surveys#create_result', as: :create_result
    get ':token/auth', to: 'sessions#new', as: :auth
  end

  namespace :account do
    get 'info', to: 'info#index'
  end
  
  resources :clients
  resources :categories
  resources :share_methods, :as => :shares, except: [:index]
  
  namespace :blog do
    resources :posts, as: 'posts', path: '/'
  end

  get 'dashboard' => 'users#dashboard', :as => :dashboard

  resource :profile

  match '/auth/:provider/callback', to: 'external_sessions#callback', provider: /twitter|facebook/
  match "/contacts/:importer/callback" => "external_sessions#contacts_callback"
  # mount Resque::Server, :at => '/resque_tasks'

  # Make sure this routeset is defined last
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)

end