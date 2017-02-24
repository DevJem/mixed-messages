Rails.application.routes.draw do 
  mount Ckeditor::Engine => '/ckeditor'
  resources :blogs
  resources :uploads
  resources :notifications, except: [:create]
  resources :contacts, only: [:new, :create]
  resources :tags, only: [:new, :create, :destroy, :index]

  post 'notify(.:format)' => 'notifications#create', as: :notify
  post 'delete-notifications/:id' => 'notifications#delete_all', as: :delete_notices

  get 'about'			      => 'pages#about'
  get 'faq'	    	      => 'pages#faq'
  get 'watch'		       	=> 'pages#watch'
  patch 'watch'         => 'pages#watch'
  get 'safe'            => 'pages#safe'
  get 'contact_us'      => 'pages#contact_us'
  get 'unsubscribe'     => 'pages#unsubscribe'
  get 'change_password' => 'pages#change_password', as: :change_password

  post 'reset'          => 'pages#password_reset', as: :password_reset
  get 'pw-reset'        => 'pages#send_pw_reset', as: :pw_reset
  post 'new_pw_by_email'    => 'pages#new_pw_by_email'

  post 'remove_email' => 'pages#remove_email'

  post 'send_email'  => 'users#send_mass_email'

  get 'submit'    => 'uploads#new'
  patch 'uploads/:id/save' => 'uploads#save_upload', as: :save_upload

  get 'signup'		=> 'users#new'
  resources :users, except: [:new]

  get 'login'			=> 'sessions#new'
  post 'login' 	  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  patch '/users/:id/ban(.:format)' => 'users#ban', as: :ban
  patch '/users/:id/make-admin(.:format)' => 'users#make_admin', as: :make_admin
  get 'elist'     => 'users#elist'

  get 'terms'     => 'uploads#terms'
  get 'privacy'   => 'uploads#privacy_policy'
  post 'add_tags' => 'uploads#add_tags'

  post 'uploads/:id' => 'uploads#update'
  resources :comments

  post 'blogs/:id' => 'blogs#add_comment'

  resources :videos
  post 'videos/new' => 'videos#create'
  post 'videos/:id' => 'videos#add_comment'

  resources :reports
  post 'unflag' => 'reports#unflag'

  get 'premium' => 'videos#premium'

  get 'market'          => 'market#index'
  get 'orders'          => 'market#orders'
  post 'mark_fulfilled' => 'market#mark_fulfilled'

  get 'review' => 'uploads#review'

  get 'logo'   => 'pages#logo'
  
  root 'pages#home'

  get 'googlefe18980250372b0b.html' => 'pages#google'
 
end
