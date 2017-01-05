Rails.application.routes.draw do
  resources :blogs

  get 'about' 	=> 'pages#about'
  get 'how-to'	=> 'pages#how_to'
  get 'watch' 	=> 'pages#watch'
  get 'contact' => 'pages#contact'

  get 'signup'  => 'users#new'
  resources :users, except: [:new]

  root 'pages#home'

end
