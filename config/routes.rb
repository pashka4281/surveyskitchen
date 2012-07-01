Surveyskitchen::Application.routes.draw do


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
