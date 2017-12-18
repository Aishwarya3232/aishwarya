Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'page#home'
  get 'about', to: 'page#about'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'add_like', to: 'likes#add_like'
  post 'add_dislike', to: 'likes#add_dislike'
  delete 'logout', to: 'sessions#destroy'
  resources :articles
  resources :users, except: [:new]
  resources :categories, except: [:destroy]
end
