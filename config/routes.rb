Rails.application.routes.draw do
  get 'messages/show'



  #get 's_page/home'
  root 's_page#home'
  resources :users do
     member do
        get :followers, :following
     end
  end
  get '/search', to: 'songs#search'
  get '/usearch', to: 'users#search'
  get '/signup', to: 'users#new'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get '/logout', to: 'session#destroy'
  resources :accont_activations, only: [:edit]
  resources :songs, only: [:new, :create, :destroy, :show, :edit] do
    resources :comments, only: [:create, :destroy]
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
 
  resources :messages, only: [:create, :index, :new]
  get '/deactivated', to: 'users#deactivate'
  resources :conversations do
    resources :messages
  end
  get '/category', to: 'songs#categories'
  get '/cat', to: 'songs#cat_add'
  get '/tags', to: 'tags#tags'
  get '/like', to: 'songs#like'
  get '/usercats', to: 'users#usercats'
  post '/usercats', to: 'users#add_cat'
  #post "photos", to: "comments#create"

  # get 'users/edit'
  # patch 'users/update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # match ':controller(/:action(/:id(.:format))', via: :get
end
