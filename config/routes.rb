CodeBeta::Application.routes.draw do
  
  resources :friendships

  resources :activities

  resources :problems do
    resources :solutions
  end

  devise_for :users
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  
  resources :users do
    get 'solutions', :on => :member
    match 'users/:id' => 'users#show', via: [:get], :as => :user
  end

  get "users/show"

  root "pages#home"

end
