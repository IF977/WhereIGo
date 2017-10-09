Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
    get 'access/login' => 'sessions#new'
    
    get 'access/success' => 'sessions#success'
    
    get 'access/error' => 'sessions#error'
    
    post 'access/auth' => 'sessions#create'
    
    get 'register' => 'register#new'
    
    get 'register/client' => 'register#new_client'
    
    post 'register/client/create' => 'register#create_client'
    
    get 'register/provider' => 'register#new_provider'
    
    post 'register/provider/create' => 'register#create_provider'
    
    get 'register/error' => 'register#error'
    
    root 'sessions#new'
  
end
