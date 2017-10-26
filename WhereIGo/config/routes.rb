Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
    get 'login' => 'account#login'
    
    post 'login/authentication' => 'account#login_authentication'
    
    get 'logout' => 'account#logout'
    
    get 'c/dashboard' => 'dashboard_client#all_establishments'
    
    get 'c/establishment/:id' => 'dashboard_client#show_establishment'
    
    get 'c/establishment/:id/review' => 'dashboard_client#user_review_establishment'
    
    get 'p/dashboard' => 'dashboard_provider#my_establishments'
    
    get 'register' => 'account#register_account'
    
    post 'register/create' => 'account#register_create_account'
    
    get 'register/role' => 'account#register_role_choice'
    
    get 'register/client' => 'account#register_role_client'
    
    get 'register/provider' => 'account#register_role_provider'
    
    get 'register/provider/establishment' => 'account#register_provider_establishment'

    get 'account' => 'account#edit'
    
    post 'account/update' => 'account#update'
    
    get 'p/my_establishments' => 'dashboard_provider#my_establishments'
    
    get 'p/establishment/show/:id' => 'dashboard_provider#show_establishment'
    
    get 'p/establishment/new' => 'dashboard_provider#new_establishment'
    
    post 'p/establishment/create' => 'dashboard_provider#create_establishment'
    
    get 'p/establishment/edit/:id' => 'dashboard_provider#edit_establishment'
    
    post 'p/establishment/update/:id' => 'dashboard_provider#update_establishment'

    
    root 'application#index' 
  
end