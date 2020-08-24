Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "trainers#index"
    
    get "trainers", to: "trainers#index"
  end
end
