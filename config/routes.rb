Rails.application.routes.draw do
  
  resources :pcustomers, :except => [:new] do
    post :index, on: :collection
    # post :filter, on: :collection
    # post :setrows, on: :collection
    post :verify, on: :collection
    post :quick_edit, on: :collection
  end

  resources :scustomers, :except => [:new] do
    post :index, on: :collection
    # post :filter, on: :collection
    # post :setrows, on: :collection
    post :verify, on: :collection
    post :quick_edit, on: :collection
  end

  resources :sadmins, :except => [:new] do 
    post :index, on: :collection
    # post :filter, on: :collection
    # post :setrows, on: :collection
    post :verify, on: :collection
    post :quick_edit, on: :collection
  end
  
  resources :customers do
    # post :index, on: :collection
    # post :filter, on: :collection
    # post :setrows, on: :collection
    post :quick_edit, on: :collection
    # post :sort, on: :collection
  end

  resources :verifieds, :except => [:new, :delete] do
    post :index, on: :collection
    # post :filter, on: :collection
    # post :setrows, on: :collection
    # post :cadmin, on: :collection
    post :quick_edit, on: :collection
  end 

  resources :tickets do
    # post :index, on: :collection
    # post :filter, on: :collection
    # post :add_comment, on: :collection
    # post :setrows, on: :collection
    # post :delete_comment, on: :collection
    # post :sort, on: :collection
  end

  resources :accounts do
    # post :index, on: :collection
    # post :sort, on: :collection
    # post :filter, on: :collection
    # post :setrows, on: :collection
    post :verify, on: :collection
    # post :quick_mail, on: :collection
    post :quick_edit, on: :collection
  end

  get "/devices/configure" => "devices#configure"
  # post "/devices/configure" => "devices#configure"

  resources :devices do
    # post :index, on: :collection
    post :configure, on: :collection
    # post :filter, on: :collection
    # post :setrows, on: :collection
    # post :saction, on: :collection
    post :configure, on: :collection
    post :resume, on: :collection
    post :add_user, on: :collection
    post :delete_log, on: :collection
    post :quick_edit, on: :collection
    # post :sort, on: :collection
  end

  # resources :admin
  get "/dashboard" => "dashboard#index"
  
  resources :dashboard, :except => [:new, :delete, :edit, :index] do
    post :search, on: :collection
    post :show_userinfo, on: :collection
    post :userinfo, on: :collection
  end

  # devise_for :users
  devise_for :users, :controllers => { :registrations => 'registrations' }, :path => '', :path_names => { :sign_in => '', :sign_up => 'new', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification' }

  # root :to=>'admin#index'
  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]  
  match "/500" => "errors#internal_error", via: [ :get, :post, :patch, :delete ]  
  match '/422' => 'errors#unprocessable_entity', via: [ :get, :post, :patch, :delete ]  
  
end
