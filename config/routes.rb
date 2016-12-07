Rails.application.routes.draw do
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
  
  resources :movies
  # map '/' to be a redirect to 'decks'
  root :to => redirect('/decks')
  
  resources :decks
  match '/decks/addAsFavorite/:id', to: 'decks#addAsFavorite', via: :get, as: 'add_favorite'
  match '/decks/:id/edit/addCard',  to: 'decks#addCard', via: :get, as: 'add_card'
  match '/decks/:id/edit/writecard', to: 'decks#writecard', via: :get, as: 'write_card'
  resources :cards
  match '/cards/:id/display', to: 'cards#index', via: :get, as: 'card_display'
  resources :groups
  match '/groups/:id/display', to: 'groups#display', via: :get, as: 'group_display'
  match '/groups/:id/addUser', to: 'groups#addUser', via: :get, as: 'group_addUser'
  match '/groups/:id/add-deck', to: 'groups#show_add_deck_to_group', via: :get, as: 'show_add_deck_to_group'
  match '/groups/:id/add-deck', to: 'groups#add_deck_to_group', via: :post, as: 'add_deck_to_group'
  match '/groups/:id/add-user', to: 'groups#show_add_user_to_group', via: :get, as: 'show_add_user_to_group'
  match '/groups/:id/add-user', to: 'groups#add_user_to_group', via: :post, as: 'add_user_to_group'
  
  match '/groups/:group_id/removedeck/:deck_id', to: 'groups#remove_deck_from_group', via: :post, as: 'remove_deck_from_group'
  
  
  
  resources :users
  match '/login', to: 'sessions#new', via: :get
  match '/login_create', to: 'sessions#create', via: :post
  match '/logout', to: 'sessions#destroy', via: :delete
  match '/update', to: 'users#update', via: :post
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
