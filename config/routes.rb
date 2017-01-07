Rails.application.routes.draw do
  resources :blogs, :videos

  get 'about'			=> 'pages#about'
  get 'how-to'		=> 'pages#how_to'
  get 'watch'			=> 'pages#watch'
  patch 'watch/' => 'pages#watch'
  get 'contact'		=> 'pages#contact'

  get 'signup'		=> 'users#new'
  resources :users, except: [:new]

  get 'login'			=> 'sessions#new'
  post 'login' 	  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  patch '/users/:id/ban(.:format)' => 'users#ban', as: :ban
  patch '/users/:id/make-admin(.:format)' => 'users#make_admin', as: :make_admin

  root 'pages#home'
 
end
