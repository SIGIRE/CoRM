Crm::Application.routes.draw do  

  resources :modeles

  resources :items


  
  match 'devis/update_contact_select/:id', :controller=>'devis', :action => 'update_contact_select'
  match 'devis/update_opportunite_select/:id', :controller=>'devis', :action => 'update_opportunite_select'
  resources :devis


  resources :relations


  resources :documents






  devise_for :user, :path => '/', :path_names => { :sign_in => "login" , :sign_up => "register"},  
  #devise_for :user, :path => '/', :path_names => { :sign_in => "login" },  
  :controllers => { :registrations => "registrations" }



  match 'opportunites/update_contact_select/:id', :controller=>'opportunites', :action => 'update_contact_select'
  resources :opportunites do
    collection do
      get 'filter'
    end
  end



  resources :origines
  
  
  resources :produits


  match 'taches/update_contact_select/:id', :controller=>'taches', :action => 'update_contact_select'
  resources :taches do
    collection do
      get 'filter'
    end
  end
  
  
  
  resources :types



  resources :comptes do
    collection do
      get 'search'
      get 'search_tel'
      get 'update_produits'
      get 'filter'
      post 'add_produit'
    end
    resources :evenements
    resources :contacts
  end
  
  

  resources :evenements




  resources :contacts do
    collection do
      get 'search'
      get 'filter'
    end
  end

  
  root :to => 'taches#index'


  resources :about

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
  # match ':controller(/:action(/:id))(.:format)'
end
