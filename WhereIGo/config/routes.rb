Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
    post 'add_profile/client' => 'account#add_client_profile'
  
    post 'add_profile/provider' => 'account#add_provider_profile'
    
    get 'login' => 'account#login'
    
    post 'login/authentication' => 'account#login_authentication'
    
    get 'logout' => 'account#logout'
    
    get 'c/dashboard' => 'dashboard_client#all_establishments'
    
    get 'c/establishment/:id' => 'dashboard_client#show_establishment'
    
    get 'c/establishment/:id/review' => 'dashboard_client#user_review_establishment'
    
    post 'c/establishment/:id/comment'=> 'dashboard_client#user_comment_establishment'
    
    get 'p/dashboard' => 'dashboard_provider#my_establishments'
    
    get 'register' => 'account#register_account'
    
    post 'register/create' => 'account#register_create_account'
    
    get 'register/profile' => 'account#register_profile_choice'
    
    get 'register/client' => 'account#register_profile_client'
    
    get 'register/c/preferences/music' => 'account#register_c_preferences_music'
    
    post 'register/c/preferences/music/create' => 'account#register_c_preferences_music_create'
    
    get 'register/c/preferences/food' => 'account#register_c_preferences_food'
    
    post 'register/c/preferences/food/create' => 'account#register_c_preferences_food_create'
    
    get 'register/c/preferences/ambient' => 'account#register_c_preferences_ambient'
    
    post 'register/c/preferences/ambient/create' => 'account#register_c_preferences_ambient_create'
    
    get 'register/provider' => 'account#register_profile_provider'
    
    get 'register/provider/establishment' => 'account#register_provider_establishment'

    post 'register/provider/establishment/create' => 'account#register_provider_establishment_create'

    get 'register/p/speciality/music' => 'account#register_p_speciality_music'
    
    post 'register/p/speciality/music/create' => 'account#register_p_speciality_music_create'
    
    get 'register/p/speciality/food' => 'account#register_p_speciality_food'
    
    post 'register/p/speciality/food/create' => 'account#register_p_speciality_food_create'
    
    get 'register/p/speciality/ambient' => 'account#register_p_speciality_ambient'
    
    post 'register/p/speciality/ambient/create' => 'account#register_p_speciality_ambient_create'
    
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