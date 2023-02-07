Rails.application.routes.draw do
  devise_for :companies, path: 'c'
  devise_for :users, path: 'u'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
