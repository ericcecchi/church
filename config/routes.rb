Church::Application.routes.draw do
  
  ## Events
  resources :services, path: '/worship'
  
  ## Sermons
  resources :sermons

  ## Community groups
  get '/community', to: 'community_groups#index', as: :community_groups
  get '/community/new', to: 'community_groups#new', as: 'new_community_group'
  get '/community/:name', to: 'community_groups#show', as: :community_group
  post '/community/', to: 'community_groups#create'
  get '/community/:name/edit', to: 'community_groups#edit', as: 'edit_community_group'
  put '/community/:name', to: 'community_groups#update'
  delete '/community/:name', to: 'community_groups#destroy'
  
  ## Missional Teams
  get '/mission', to: 'missional_teams#index', as: :missional_teams
  get '/mission/new', to: 'missional_teams#new', as: 'new_missional_team'
  get '/mission/:name', to: 'missional_teams#show', as: :missional_team
  post '/mission/', to: 'missional_teams#create'
  get '/mission/:name/edit', to: 'missional_teams#edit', as: 'edit_missional_team'
  put '/mission/:name', to: 'missional_teams#update'
  delete '/mission/:name', to: 'missional_teams#destroy'

  ## Docs
  get '/docs/rails'
  get '/docs/admin_dash'
  
  ## Auth
  match '/auth/:provider/callback', to: 'authentications#create'
  match '/auth/failure', to: 'authentications#index'
  resources :authentications, path: '/users/auth'
  
  ## Admin
  match '/admin', to: "admin#index"
  get '/admin/community', as: 'manage_community_groups'
  get '/admin/mission', as: "manage_missional_teams"
  get '/admin/users', as: "manage_users"
    
  ## Users
  devise_for :users, path_names: { :sign_up => "register", :sign_in => "signin", sign_out: "signout" }, controllers: { :registrations => 'accounts' }
  get '/users/', to: 'users#index', as: :users
  get '/:display_name', to: 'users#show', as: :user
  post '/users/create', to: 'users#create'
  get '/users/new', to: 'users#new', as: 'new_user'
  get '/:display_name/edit', to: 'users#edit', as: 'edit_user'
  put '/:display_name', to: 'users#update'
  delete '/:display_name', to: 'users#destroy'
  
  ## Roles
  resources :roles
  
  ## Root
  root to: "home#index"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
