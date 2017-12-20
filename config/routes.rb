Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'page#home'
  get 'about', to: 'page#about'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'add_comment', to: 'articles#add_comment'
  post 'add_like', to: 'articles#add_like'
  post 'add_dislike', to: 'articles#add_dislike'
  delete 'logout', to: 'sessions#destroy'
  delete 'delete_comment', to: 'articles#delete_comment'
  resources :articles
  resources :users, except: [:new]
  resources :categories, except: [:destroy]
end
