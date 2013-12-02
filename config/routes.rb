MyculverhouseStock::Application.routes.draw do

  
  
  ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')
  
  # Make sure this routeset is defined last
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)

  resources :action_items

  root to: 'index#index'

  get "department_admin_actions/updateFacultyProfile"

  get "department_admin_actions/updateUserPicture"

  get "department_admin_actions/updatePublication"

  get "department_admin_actions/addUser"

  get "department_admin_actions/submitProfileForDeletion"

  get "department_admin_actions/createFacultyUser"

  get "college_admin_actions/updateFacultyProfile"

  get "college_admin_actions/updateUserPicture"

  get "college_admin_actions/updatePublication"

  get "college_admin_actions/addUser"

  get "college_admin_actions/submitProfileForDeletion"

  get "college_admin_actions/createFacultyUser"

  get "college_admin_actions/deleteFacultyUser"

  get "college_admin_actions/createDepartmentAdmin"

  get "college_admin_actions/deleteDepartmentAdmin"

  get "college_admin_actions/editUser"

  get "college_admin_actions/deleteFacultyProfile"

  get "password_resets/new" 
  
  resources :publications

  resources :user_pictures
  resources :calendar_items

  resources :news_items

  resources :users

  resources :faculty_profiles

  get "login" => 'login#new'
  post "login" => 'login#create'
  delete "logout" => 'login#destroy'

  resources :password_resets do
    post 'edit' => :update
  end

  get "/password_reset" => 'password_resets#new'
  get "/password_resets/:id/edit" => 'password_resets#edit'

  get "/faculty/:permalink", :controller => 'faculty_profiles', :action => :show

  post "/action_items/:id" => "action_items#approve"

  get "/calendar" => "master_calendar#index"
  post "/calendar" => "master_calendar#index"

  get "/news" => "news#index"
  post "/news" => "news#index"

  ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')
  
  # Make sure this routeset is defined last
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
