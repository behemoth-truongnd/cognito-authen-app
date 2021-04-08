Rails.application.routes.draw do
  root to: 'home#index'

  namespace :console do
    root to: 'home#index'
    delete "logout", to: "sessions#destroy"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
