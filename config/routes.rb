Birds::Application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  ActiveAdmin.routes(self)

  devise_for :users,
             :controllers => { registrations: 'users',
                               omniauth_callbacks: 'users/omniauth_callbacks' },
             path: '/user',
             skip: :registrations

  devise_scope :user do
    get 'users', to: 'users#index'
    post 'user', to: 'users#create', as: :user_registration
    get 'user/sign_up', to: 'users#new', as: :new_user_registration
    put 'user/change_password', to: 'users#change_password'
    get 'user/unregister', to: 'users#unregister', as: :user_unregister
  end

  resources :profiles, only: [:show, :update]

  root to: 'pages#index'

  resource :pages, path: '', only: [] do
    get :about
    get :birding_rules
    get :approve
    get :show_new
    get :show_commentable
    get :show_unknown
    get :help
  end

  resource :big_year, only: [] do
    get :index
    post :change_subscription
  end

  resources :species, only: [:index, :show] do

  end

  resources :map, only: [:index]

  resources :birds, except: [:index] do
    member do
      get 'edit_date' => 'birds#edit_date'
      get 'edit_map' => 'birds#edit_map'
      get 'edit_species' => 'birds#edit_species'
      get 'publish' => 'birds#publish'
      post 'approve' => 'birds#approve'
    end
  end

  resources :categories, only: [:index]

  resources :comments, only: [:create, :destroy]

  resource :search, path: '', only: [] do
    get 'search' => 'search#index'
    post 'search' => 'search#search'
    post 'main_species' => 'search#search_main_species'
  end

  resource :contest, only: [] do
    get 'big_day_in_ecocenter'
    get 'big_day_in_tashkent'
    get 'big_day_photo'
    get 'big_day_photo_species'
    get 'big_day_photo_form'
    get 'big_day_photo_rules'
    get 'best_photo'
    get 'best_photo_file'
    get 'our_friend'
    get 'past'
    get 'winter_bird_watch'
    get 'big_year_result'
    get 'big_year_species'
    get 'shorebird_day'
  end

  resource :swift, only: [] do
    get 'nesting_box'
    get 'first_aid'
    get 'about'
  end

  get 'become/:id', to: 'admin#become'

end
