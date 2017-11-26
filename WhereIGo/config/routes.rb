Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
    get 'permission/provider' => 'account#add_provider_permission'
    
    get 'login' => 'account#login'
    
    post 'login/authentication' => 'account#login_authentication'
    
    get 'logout' => 'account#logout'
    
    get 'dashboard/recommended_establishments' => 'dashboard#preference_establishments_result'
    
    get 'dashboard/all_establishments' => 'dashboard#all_establishments'
    
    get 'dashboard/recommended_establishments' => 'dashboard#preference_establishments_result'
    
    get 'search/establishments' => 'dashboard#search_establishments'
    
    get 'establishment/:id' => 'dashboard#show_establishment'
    
    get 'establishment/:id/review' => 'dashboard#user_review_establishment'
    
    post 'establishment/:id/comment'=> 'dashboard#user_comment_establishment'
    
    get 'dashboard/my_establishments' => 'dashboard#my_establishments'
    
    get 'register' => 'account#register_account'
    
    post 'register/create' => 'account#register_create_account'
    
    get 'register/profile' => 'account#register_profile_choice'
    
    get 'register/client' => 'account#register_profile_client'
    
    get 'register/preferences/music' => 'account#register_preferences_music'
    
    post 'register/preferences/music/create' => 'account#register_preferences_music_create'
    
    get 'register/preferences/food' => 'account#register_preferences_food'
    
    post 'register/preferences/food/create' => 'account#register_preferences_food_create'
    
    get 'register/preferences/ambient' => 'account#register_preferences_ambient'
    
    post 'register/preferences/ambient/create' => 'account#register_preferences_ambient_create'
    
    get 'register/provider' => 'account#register_profile_provider'
    
    get 'register/provider/establishment' => 'account#register_provider_establishment'

    post 'register/provider/establishment/create' => 'account#register_provider_establishment_create'

    get 'register/speciality/music' => 'account#register_speciality_music'
    
    post 'register/speciality/music/create' => 'account#register_speciality_music_create'
    
    get 'register/speciality/food' => 'account#register_speciality_food'
    
    post 'register/speciality/food/create' => 'account#register_speciality_food_create'
    
    get 'register/speciality/ambient' => 'account#register_speciality_ambient'
    
    post 'register/speciality/ambient/create' => 'account#register_speciality_ambient_create'
    
    get 'dashboard/account' => 'account#edit'
    
    post 'dashboard/account/update' => 'account#update'
    
    get 'dashboard/my_establishments' => 'dashboard#my_establishments'
    
    get 'dashboard/establishment/new' => 'dashboard#new_establishment'
    
    post 'dashboard/establishment/create' => 'dashboard#create_establishment'
    
    get 'dashboard/my_establishment/edit/:id' => 'dashboard#edit_my_establishment'
    
    post 'dashboard/my_establishment/update/:id' => 'dashboard#update_my_establishment'
    
    get 'dashboard/my_establishment/remove/:id' => 'dashboard#remove_my_establishment'
    
    get 'backoffice/import' => 'back_office#import_all_data'
    
    post 'backoffice/bootstrap/data' => 'back_office#bootstrap_all_data'

    root 'application#index'
    
end