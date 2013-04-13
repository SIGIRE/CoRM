Crm::Application.routes.draw do  
  
  def set_route(pp, ps, c)
  # ex:    c => Tag
    # GET    tags/ => tags_path
    match "#{pp}(.:format)",   :controller => c,  :action => 'index',     :via => :get,   :as => c
    # POST   tags/ => tags_path(:tag)
    match "#{pp}(.:format)",   :controller => c,  :action => 'create',    :via => :post,  :as => c
    # GET    tags/new => new_tag_path
    match "#{ps}/new(.:format)",         :controller => c,  :action => 'new',       :via => :get,   :as => "new_#{c.singularize}"
    # GET    tags/:id/edit
    match "#{ps}/:id/edit(.:format)",    :controller => c,  :action => 'edit',      :via => :get,   :as => "edit_#{c.singularize}"
    # GET    tags/:id => tag_path(:tag)
    match "#{ps}/:id(.:format)",         :controller => c,  :action => 'show',      :via => :get,   :as => "#{c.singularize}"
    # PUT    tags/:id => tag_path(:tag)
    match "#{ps}/:id(.:format)",         :controller => c,  :action => 'update',    :via => :put,   :as => "#{c.singularize}"
    # DELETE tags/:id => tag_path(:tag)
    match "#{ps}/:id(.:format)",         :controller => c,  :action => 'destroy',   :via => :delete, :as => "#{c.singularize}"
  end
  
 # mount Ckeditor::Engine => '/ckeditor'

  match 'extractions/select_param_accounts', :controller=>'extractions', :action => 'select_param_accounts'
  match 'extractions/comptes', :controller=>'extractions', :action => 'accounts', :as => :csv
  match 'extractions/select_param_contacts', :controller=>'extractions', :action => 'select_param_contacts'
  match 'extractions/contacts', :controller=>'extractions', :action => 'contacts', :as => :csv
  
  # Resources needed for form_for support with a composed name Class (eventType)
  #
  #resources :eventTypes, :path => 'type-evenement'
  match 'type-evenements(.:format)', to: 'eventTypes#index', via: :get, as: :event_types
  match 'type-evenements(.:format)', to: 'eventTypes#create', via: :post, as: :event_types
  match 'type-evenement/new(.:format)', to:'eventTypes#new', via: :get, as: :new_event_type
  match 'type-evenement/:id/edit(.:format)', to: 'eventTypes#edit', via: :get, as: :edit_event_type
  match 'type-evenement/:id(.:format)', to: 'eventTypes#show', via: :get, as: :event_type
  match 'type-evenement/:id(.:format)', to: 'eventTypes#update', via: :put, as: :event_type
  match 'type-evenement/:id(.:format)', to: 'eventTypes#destroy', via: :delete, as: :event_type
  
  # Resources needed for form_for support with a composed name Class (quotationTemplate)
  #
  #resources :eventTypes, :path => 'type-evenement'
  match 'modele-devis(.:format)', to: 'quotationTemplates#index', via: :get, as: :quotation_templates
  match 'modele-devis(.:format)', to: 'quotationTemplates#create', via: :post, as: :quotation_templates
  match 'modele-devis/new(.:format)', to:'quotationTemplates#new', via: :get, as: :new_quotation_template
  match 'modele-devis/:id/edit(.:format)', to: 'quotationTemplates#edit', via: :get, as: :edit_quotation_template
  match 'modele-devis/:id(.:format)', to: 'quotationTemplates#show', via: :get, as: :quotation_template
  match 'modele-devis/:id(.:format)', to: 'quotationTemplates#update', via: :put, as: :quotation_template
  match 'modele-devis/:id(.:format)', to: 'quotationTemplates#destroy', via: :delete, as: :quotation_template
  #resources :quotationTemplates, :path => 'modele-devis'
  
  resources :quotationLines

  # Quotations routes
  set_route('devis', 'devis', 'quotations')  
  match 'devis/update_contact_select/:id', :controller=>'quotations', :action => 'update_contact_select'
  match 'devis/update_opportunity_select/:id', :controller=>'quotations', :action => 'update_opportunity_select'

  # Relations routes
  set_route('relations', 'relation', 'relations')
  # Documents routes
  set_route('documents', 'document', 'documents')
  
  devise_for :user, :path => '/', :path_names => { :sign_in => "login", :sign_out => 'logout', :sign_up => "register" },  
  :controllers => { :registrations => "registrations" }

  # Opportunities routes
  set_route('opportunites', 'opportunite', 'opportunities')  
  match 'opportunites/update_contact_select/:id', :controller=>'opportunities', :action => 'update_contact_select'
  match 'opportunites/filter(.:format)', :controller => 'opportunities', :action => 'filter', :via => :get, :as => "filter_opportunity_index"


  # Origin routes
  # resources :origins
  set_route('origines', 'origine', 'origins');
  # Tag routes
  # resources :tags
  set_route('tags', 'tag', 'tags');

  match 'taches/update_contact_select/:id', :controller=>'tasks', :action => 'update_contact_select'
  
  # Tasks routes
  set_route('taches', 'tache', 'tasks')
  match 'taches/filter(.:format)', :controller => 'tasks', :action => 'filter', :via => :get, :as => "filter_tasks"

  # TODO: Accounts
  match 'comptes/delete_tag', :controller=> 'accounts', :action =>'delete_tag'
  resources :accounts, :path => 'compte' do
    collection do
      get 'search'
      get 'search_tel'
      get 'update_tags'
      get 'filter'
      post 'add_tag'
    end
    resources :events, :path => 'evenements'
    resources :contacts
  end
  match 'comptes', :controller => 'accounts', :action => 'index'
  
  # Events routes
  set_route('evenements', 'evenement', 'events')

  # Contacts routes
  set_route('contacts', 'contact', 'contacts');
  match 'contacts/search(.:format)', :controller => 'contacts', :action => 'search', :via => :get, :as => "search_contact_index"
  match 'contacts/filter(.:format)', :controller => 'contacts', :action => 'filter', :via => :get, :as => "search_contact_index"
  
  root :to => 'tasks#index'


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
