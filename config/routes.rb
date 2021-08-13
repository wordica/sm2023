Rails.application.routes.draw do
 
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
    
  },:path => '', :path_names => { :sign_in => "sigin", :sign_out => "logout", :sign_up => "sign-up"}



  unauthenticated :user do

    devise_scope :user do
      root :to => 'pages#home' , :as => :root_path
    end
    
  end

  root to: 'pages#home_logged_in'

  

  match 'tags/tag_delete' => 'tags#tag_delete', :as => :tag_delete, :via => [:get, :post]

  get '/pages/:page' => 'pages#home_logged_in'
  resources :pages
  resources :profiles
  resources :searches
  resources :photos
  resources :users
  resources :tags

end
