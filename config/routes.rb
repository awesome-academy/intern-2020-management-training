Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    namespace :trainers do
      root "trainers#index"
      resources :subjects, except: %i(edit update)
      resources :courses
    end
    
    namespace :trainee do
      root "courses#index"
      resources :courses do
        resources :subjects
      end
    end
  end
end
