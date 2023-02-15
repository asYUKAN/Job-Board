Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :addresses
  devise_for :companies,  controllers: { sessions: "companies/sessions", registrations: "companies/registrations", confirmations: "companies/confirmations", passwords: "companies/passwords", unlocks: "companies/unlocks", index:"companies/index"}
  devise_for :users,  controllers: { sessions: "users/sessions", registrations: "users/registrations", confirmations: "users/confirmations",  passwords: "users/passwords", unlocks: "users/unlocks"}

  resources :job_posts, only: [:new, :create, :show, :edit, :update, :destroy, :index, :company_job_posts, :share]
  resource :users

  resource :companies
  resource :address

  resource :job_application
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root to: "job_posts#index"
  # devise_scope :user do
  #   root to: "users/sessions#new"
  # end

  get '/share', to: "job_posts#share"
  get '/company_posts', to: "job_posts#company_job_posts"
  get '/job_applications', to: "job_applications#user_job_applications"
  get '/job_applicants/:id', to: 'job_posts#job_post_applicants'

  get '/search', to: 'job_posts#search'
end