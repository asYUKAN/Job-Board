Rails.application.routes.draw do
  devise_for :companies,  controllers: { sessions: "companies/sessions", registrations: "companies/registrations", confirmations: "companies/confirmations", passwords: "companies/passwords", unlocks: "companies/unlocks"}
  devise_for :users,  controllers: { sessions: "users/sessions", registrations: "users/registrations", confirmations: "users/confirmations",  passwords: "users/passwords", unlocks: "users/unlocks"}

  #resources :users, only: [:show, :edit, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
