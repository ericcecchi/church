Church::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  ## Events
  resources :events
  resources :services, path: '/worship'
  
  ## Sermons
  resources :sermons

  ## Messages
  match '/messages/inbox', as: 'inbox', to: 'direct_messages#inbox'
  match '/messages/sent', as: 'sent', to: 'direct_messages#sent'
  resources :direct_messages, path: 'messages'

  ## Groups
	resources :groups do
		resources :discussions
	end
	
  ## Docs
  get '/docs/rails'
  get '/docs/future'
  get '/docs/admin_dash'
  
  ## Auth
  match '/auth/:provider/callback', to: 'authentications#create'
  match '/auth/failure', to: 'authentications#index'
  resources :authentications, path: '/users/auth'
    
  ## Users
  devise_for :users, path_names: { sign_up: "register", sign_in: "signin", sign_out: "signout" }, controllers: { registrations: 'accounts' }
  resources :users
# 
#   get '/:display_name', to: 'users#show', as: :user
#   get '/:display_name/edit', to: 'users#edit', as: 'edit_user'
#   put '/:display_name', to: 'users#update'
  
  ## Admin
  match '/admin/groups', as: 'manage_groups', to: 'groups#index'
  match '/admin/users', as: "manage_users", to: 'users#index'
  
  ## Roles
  resources :roles
  
  ## Root
  match '/dashboard', to: "dashboard#index", as: 'dashboard'
  root to: "dashboard#index"
end
