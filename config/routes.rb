Surveyskitchen::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root to: 'home#index'

  get :tos, to: 'home#tos'
  get :about, to: 'home#about'

  resources :surveys do
    get :builder, on: :member
    get :deploy,  on: :member
    get :trashbox, on: :member
    get :report, on: :member
    resources :survey_items, as: 'items', path: 'items' do
      delete :delete, as: :member
    end
    resources :responses, only: [:show, :destroy, :index]
  end

  namespace :s do
    get   ':token', to: 'surveys#show', as: :show_survey
    post  ':token', to: 'surveys#create_result', as: :create_result
  end

  namespace :account do
    get 'info', to: 'info#index'
  end
  
  resources :categories

  get 'dashboard' => 'users#dashboard', :as => :dashboard

  get   'login',    to: 'sessions#new'
  post  'login',    to: 'sessions#create'
  get   'logout',   to: 'sessions#destroy'
  get   'register', to: 'users#new'
  post  'register', to: 'users#create'

  get 'profile', to: 'users#profile'
  put 'profile_update', to: 'users#profile_update'

  match '/auth/:provider/callback', to: 'external_sessions#callback', provider: /twitter|facebook/

end