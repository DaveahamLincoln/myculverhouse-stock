MyculverhouseStock::Application.routes.draw do

  #Loads the opinio engine for comment handling
  opinio_model

  root to: 'index#index'

  get "login" => 'login#new'
  post "login" => 'login#create'
  delete "logout" => 'login#destroy'

  get "password_resets/new" 
  get "/password_reset" => 'password_resets#new'
  get "/password_resets/:id/edit" => 'password_resets#edit'

  resources :password_resets do
    post 'edit' => :update
  end

  post "/action_items/:id" => "action_items#approve"
  resources :action_items

  get '/locations/labels/:id', to: "locations#label"
  resources :locations

  resources :publications

  resources :user_pictures

  resources :calendar_items

  resources :news_items

  resources :users

  resources :programs, :except => [:show,:edit]

  #CONSTANT VIGILANCE!  ROUTES LOAD IN ORDER.  I had a 'resources :departments' entry here, which was overriding the 
  #:except direction below.  Took me two hours to fix.  Pay attention to the order.

  resources :departments, :except => [:show,:edit]
  get "/departments/shard/:id" => "departments#show"
  get "/departments/shard/:id/edit" => "departments#edit"

  resources :centers, :except => [:show,:edit]

  #Managed CMS hook.  Uncomment to reenable.
  #resources :faculty_profiles

  get "/calendar" => "master_calendar#index"
  post "/calendar" => "master_calendar#index"

  get "/news" => "news#index"
  post "/news" => "news#index"
  get "/news/:id" => "news#mark_as_blogged"

  get "/faculty" => "faculty#index"
  post "/faculty" => "faculty#index"

  get '/equipment/labels/:id', to: "equipment#label"
  resources :equipment

  post '/computer_program_associations/:equipmentID', to: "computer_program_associations#new"
  post '/computer_program_associations/uninstall/:equipmentID', to: "computer_program_associations#uninstall"
  resources :computer_program_associations, :only => [:index, :create, :update, :destroy, :show]

  post '/printer_associations/:equipmentID', to: "printer_associations#new"
  post '/printer_associations/uninstall/:equipmentID', to: "printer_associations#uninstall"
  resources :printer_associations, :only => [:index, :create, :update, :destroy, :show]

  resources :computer_programs

  post '/trouble_tickets/:id', to: "trouble_tickets#close"
  #!TODO figure out a way to do this
  #post '/trouble_tickets/new/:id', to: "trouble_tickets#add_to_equipment"
  get "trouble_tickets/closed_tickets" => "trouble_tickets#closed_tickets"
  get "trouble_tickets/supervisor_tickets" => "trouble_tickets#supervisor_tickets"
  
  resources :trouble_tickets do
    member do
      post 'accept_ticket' => :accept_ticket
      #Enables commenting for the associated route.
      opinio
    end
  end

  post '/lab_tickets/:id', to: 'lab_tickets#close'
  post '/lab_tickets/:labTicketID/new_task', to: "tasks#new"
  get "lab_tickets/closed_tickets" => "lab_tickets#closed_tickets"
  resources :lab_tickets do
    member do
      opinio
    end
  end

  post '/tasks/:id', to: 'tasks#close'
  resources :tasks do
    member do
      opinio
    end
  end

  post '/jobs/:ticketID', to: "jobs#new"
  post '/jobs/:ticketID/complete/:id', to: "jobs#complete"
  post '/jobs/:ticketID/reopen/:id', to: "jobs#reopen"
  resources :jobs, :only => [:index, :create, :update, :destroy, :show]

  # This line mounts Monologue's routes at the root of your application.
  # This means, any requests to URLs such as /my-post, will go to Monologue::PostsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Monologue relies on it being the default of "monologue"
  mount Monologue::Engine, at: '/blog' # or whatever path, be it "/blog" or "/monologue"

  # Binds CMS admin path to /cms_admin
  ComfortableMexicanSofa::Routing.admin(:path => '/cms_admin')
  
  # Make sure this routeset is defined last
  # Allows CMS content to propagate from '/'
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)

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

