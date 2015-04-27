  Swirlysurvey::Application.routes.draw do
  
  # The priority is based upon order of creation:
  # first created -> highest priority.
  root :to => 'dashboard#index', :format => false
  resources :survey_templates, param: :uuid
  resources :submissions
  resources :courses # courses/edit, courses/create

  # root :to => 'survey_templates#index'
  
  get 'admin', :to => 'dashboard#index', :format => false, :as => :dashboard
  get 'admin/update_user', :to => 'dashboard#update_user', :format => false, :as => :admin_update_user
  post 'admin_update_user_pathin/change_user', :to => 'dashboard#change_user', :format => false, :as => :admin_change_user
  get 'admin/login', :to => 'dashboard#login', :format => false, :as => :dashboard_login

  get 'survey_templates/:id/all_responses', :to => 'survey_templates#all_responses', :as => :all_responses
  get 'survey_templates/:id/participants', :to => 'survey_templates#participants', :as => :all_participants
  get 'survey_templates/:id/download_:type', :to => 'survey_templates#download_data', :as => :download_data
  post 'survey_templates/:id/clone', :to => 'survey_templates#clone'

  get 'survey_templates/:id/status', :to => 'survey_templates#status', :as => :survey_template_status
  put 'survey_templates/:id/status', :to => 'survey_templates#update_status', :as => :update_survey_template_status

  get 'survey_templates/:id/responses_data', :to => 'survey_templates#responses_data', :as => :responses_data


  # for omniauth login 
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy', as: 'signout'

  post 'courses/add_editor', :to => 'courses#add_editor', :as => :add_people
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
