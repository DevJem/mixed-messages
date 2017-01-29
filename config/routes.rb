Rails.application.routes.draw do 
  mount Ckeditor::Engine => '/ckeditor'
  resources :blogs
  resources :uploads
  resources :notifications, except: [:create]

  post 'notify(.:format)' => 'notifications#create', as: :notify
  post 'delete-notifications/:id' => 'notifications#delete_all', as: :delete_notices

  get 'about'			=> 'pages#about'
  get 'faq'	    	=> 'pages#faq'
  get 'watch'			=> 'pages#watch'
  patch 'watch'   => 'pages#watch'
  get 'contact'		=> 'pages#contact'

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
  post 'uploads/:id' => 'uploads#update'
  resources :comments

  post 'blogs/:id' => 'blogs#add_comment'

  resources :videos
  post 'videos/new' => 'videos#create'
  post 'videos/:id' => 'videos#add_comment'

  get 'premium' => 'videos#premium'

  get 'market' => 'market#index'

  get 'review' => 'uploads#review'
  
  root 'pages#home'
 
end
