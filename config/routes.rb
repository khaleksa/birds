Birds::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users,
             :controllers => { registrations: 'users' },
             path: '/user',
             skip: :registrations

  devise_scope :user do
    post 'user', to: 'users#create', as: :user_registration
    get 'user/sign_up', to: 'users#new', as: :new_user_registration
    put 'user/change_password', to: 'users#change_password'
    get 'user/unregister', to: 'users#unregister', as: :user_unregister
  end

  resources :profiles, only: [:show, :update]

  root to: 'pages#index'

  resource :pages, path: '', only: [] do
    get :big_year
    get :about
    get :unknowns
  end

  resources :species, only: [:index, :show]

  resources :birds, except: [:index] do
    member do
      get 'edit_date' => 'birds#edit_date'
      get 'edit_map' => 'birds#edit_map'
      get 'edit_species' => 'birds#edit_species'
      get 'publish' => 'birds#publish'
    end
  end

  resources :categories, only: [:index]

  resources :comments, only: [:create]

  resource :search, path: '', only: [] do
    get 'search' => 'search#index'
    post 'search' => 'search#search'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
