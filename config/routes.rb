Surveyskitchen::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  match '/:locale' => 'home#index', :locale => /en|ru/, as: :locale_root
  root to: 'home#locale_redirect'
  scope "/:locale", :locale => /en|ru/ do
    get :tos, to: 'home#tos'
    get :about, to: 'home#about'
    get :plans, to: 'home#plans'
    get :features, to: 'home#features'

      get   'login',    to: 'sessions#new'
  post  'login',    to: 'sessions#create'

  get   'register', to: 'users#new'
  post  'register', to: 'users#create'
  end
  
  get   'logout',   to: 'sessions#destroy'
  get :switch_locale, to: 'home#switch_locale'


  get :theme_preview, to: 'themes#theme_preview'

  resources :surveys do
    get :builder,   on: :member
    get :share,     on: :member
    get :trashbox,  on: :member
    get :report,    on: :member
    put :switch,    on: :member
    get :preview,   on: :member
    get :look,      on: :member
    resources :survey_items, as: 'items', path: 'items' do
      delete :delete, as: :member
      post :copy, as: :member
    end
    resources :responses, only: [:show, :destroy, :index]
    resources :themes
  end

  namespace :s do
    get   ':token', to: 'surveys#show', as: :show_survey
    post  ':token', to: 'surveys#create_result', as: :create_result
  end

  namespace :account do
    get 'info', to: 'info#index'
  end
  
  resources :clients
  resources :categories

  get 'dashboard' => 'users#dashboard', :as => :dashboard

  resource :profile

  match '/auth/:provider/callback', to: 'external_sessions#callback', provider: /twitter|facebook/

end