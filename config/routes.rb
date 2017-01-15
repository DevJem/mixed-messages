Rails.application.routes.draw do
  resources :blogs
  resources :uploads
  resources :notifications


  get 'about'			=> 'pages#about'
  get 'how-to'		=> 'pages#how_to'
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

  post 'uploads/:id' => 'uploads#update'
  resources :comments

  post 'blogs/:id' => 'blogs#add_comment'

  resources :videos
  post 'videos/new' => 'videos#create'
  post 'videos/:id' => 'videos#add_comment'

  get 'premium' => 'videos#premium'

  get 'market' => 'market#index'

  

  root 'pages#home'
 
end
