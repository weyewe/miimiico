Pilipoto::Application.routes.draw do
  devise_for :users

  root :to => 'home#index'
  
  resources :users do 
    resources :projects
  end
  
  resources :projects do
    resources :pictures
  end
  
  resources :profiles
  
  match 'edit_profile_pic' => "profiles#edit_profile_pic", :as => :edit_profile_pic
  match 'update_profile_pic' => "profiles#update_profile_pic", :as => :update_profile_pic, :method => :put
  match 'show_collaborators/:project_id' => "projects#show_collaborators", :as => :show_collaborators
  match 'add_comment/:picture_id/' => 'pictures#add_comment', :as => :add_comment, :method => :post
  match 'add_positional_comment/:picture_id/' => 'pictures#add_positional_comment', :as => :add_positional_comment, :method => :post
  
  match 'create_revision' => "pictures#create_revision"  , :as => :create_revision, :method => :post
  
  match 'edit_credential' => "passwords#edit_credential" , :as => :edit_credential
  match 'update_password' => "passwords#update" , :as => :update_password, :method => :put
  
  match 'edit_username' => "passwords#edit_username" , :as => :edit_username
  match 'update_username' => "passwords#update_username" , :as => :update_username, :method => :put
  
  match 'add_collaborator' => "projects#add_collaborator" , :as => :add_collaborator, :method => :post
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
