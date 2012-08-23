Church::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  ## Events
  resources :services, path: '/worship'
  
  ## Sermons
  resources :sermons

  ## Groups
  resources :groups

  ## Docs
  get '/docs/rails'
  get '/docs/future'
  get '/docs/admin_dash'
  
  ## Auth
  match '/auth/:provider/callback', to: 'authentications#create'
  match '/auth/failure', to: 'authentications#index'
  resources :authentications, path: '/users/auth'
  
  ## Admin
  get '/admin/groups', as: 'manage_groups'
  get '/admin/users', as: "manage_users"
    
  ## Users
  devise_for :users, path_names: { :sign_up => "register", :sign_in => "signin", sign_out: "signout" }, controllers: { :registrations => 'accounts' }
	scope "/admin" do
	  resources :users
	end
# 
#   get '/:display_name', to: 'users#show', as: :user
#   get '/:display_name/edit', to: 'users#edit', as: 'edit_user'
#   put '/:display_name', to: 'users#update'
  
  ## Roles
  resources :roles
  
  ## Root
  match '/dashboard', to: "dashboard#index", as: 'dashboard'
  root to: "dashboard#index"
end
