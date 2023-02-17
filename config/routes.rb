Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :addresses
  devise_for :companies,  controllers: { sessions: "companies/sessions", registrations: "companies/registrations", confirmations: "companies/confirmations", passwords: "companies/passwords", unlocks: "companies/unlocks"}
  devise_for :users,  controllers: { sessions: "users/sessions", registrations: "users/registrations", confirmations: "users/confirmations",  passwords: "users/passwords", unlocks: "users/unlocks"}

  resources :job_posts, only: [:new, :create, :show, :edit, :update, :destroy, :index, :company_job_posts, :share]
  resource :users

  resource :companies
 

  resource :job_application

  resource :discussion
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

  post '/discussion/question', to: 'discussions#create_question'
  post '/discussion/answer', to: 'discussions#create_answer'
  get '/search', to: 'job_posts#search'


  # Admin--------------------------
  delete 'job_post/delete', to: 'main#destroy_job_post'
  delete 'discussion/delete', to: 'main#destroy_discussion'
  delete 'reply/delete', to: 'main#destroy_reply'
  delete 'company/delete', to: 'main#destroy_company'
  delete 'user/delete', to: 'main#destroy_user'

  get  'companies/index', to: 'main#show_companies'
  get  'users/index', to: 'main#show_users'

  #----------------------
end