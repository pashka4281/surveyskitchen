Surveyskitchen::Application.routes.draw do

  resources :surveys do
    get "builder", :on => :member
    resources :survey_items, as: 'items', path: 'items' do
      delete :delete, as: :member
    end
  end
  
  resources :categories

  get "dashboard" => 'home#dashboard', :as => :dashboard

  devise_for :users

  devise_scope :user do
    get "login", to: "devise/sessions#new"
    post "login", to: "devise/sessions#create"
    get "logout", to: "devise/sessions#destroy"
    get "register", to: "devise/registrations#new"
    post "register", to: "devise/registrations#create"
  end

end
