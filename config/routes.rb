Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    resources :trainers, only: :index

    namespace :trainers do
      resources :subjects, only: [:new, :index]
    end
  end
end
