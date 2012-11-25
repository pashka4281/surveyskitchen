Surveyskitchen::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root to: 'home#index'

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
  
  resources :categories

  get 'dashboard' => 'users#dashboard', :as => :dashboard

  get   'login',    to: 'sessions#new'
  post  'login',    to: 'sessions#create'
  get   'logout',   to: 'sessions#destroy'
  get   'register', to: 'registrations#new'
  post  'register', to: 'registrations#create'

end