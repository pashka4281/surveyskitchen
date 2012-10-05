Surveyskitchen::Application.routes.draw do

  resources :surveys do
    get :builder, on: :member
    get :deploy,  on: :member
    resources :survey_items, as: 'items', path: 'items' do
      delete :delete, as: :member
    end
  end
  
  resources :categories

  get "dashboard" => 'home#dashboard', :as => :dashboard


  devise_for :users, skip: [:sessions, :registrations],  controllers: {
      omniauth_callbacks: 'external_sessions', sessions: 'sessions', registrations: 'registrations' } do
    get   'login',    to: 'sessions#new'
    post  'login',    to: 'sessions#create'
    get   'logout',   to: 'sessions#destroy'
    get   'register', to: 'registrations#new'
    post  'register', to: 'registrations#create'
  end

end
