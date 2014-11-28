CodeBeta::Application.routes.draw do
  
  resources :friendships

  resources :activities

  resources :problems do
    resources :comments
    resources :solutions do
      member { post :vote }
      resources :comments
    end
    member { post :vote }
  end

  devise_for :users
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  
  resources :users do
    get 'solutions', :on => :member
    match 'users/:id' => 'users#show', via: [:get], :as => :user
  end

  get "users/show"

  get "users" => 'users#index'
  # get 'users/:id'

  get "solutions" => "solutions#solutions"

  get "unanswered" => "problems#unanswered"

  get 'tags/:tag', to: 'problems#index', as: :tag



  # get 'tags/:tag', to: 'problems#index', as: :tag

  # get 'users/:id' => 'users#show', as: :user
  # match 'users/:id' => 'users#show', via: [:get], :as => :user

  # get  '/users/edit(.:format)' => 'devise/registrations#edit', via: [:get], :as => 'settings'
  
  get "about" => "pages#about" #creates about_path

  root "problems#index"

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
