Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
    get '/login' => 'sessions#new'
    
    get 'login/success' => 'sessions#success'
    
    get 'login/error' => 'sessions#error'
    
    post 'login/auth' => 'sessions#create'
    
    get 'register' => 'register#new'
    
    get 'register/client' => 'register#new_client'
    
    post 'register/client/create' => 'register#create_client'
    
    get 'register/provider' => 'register#new_provider'
    
    post 'register/provider/create' => 'register#create_provider'
    
    get 'register/error' => 'register#error'
    
    get '/logout' => 'sessions#destroy'
    
    root 'sessions#new'
  
end
