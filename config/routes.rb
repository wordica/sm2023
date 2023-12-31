Rails.application.routes.draw do
 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: "users/confirmations"
    
  },:path => '', :path_names => { :sign_in => "sign-in", :sign_out => "logout", :sign_up => "sign-up"}



  unauthenticated :user do

    devise_scope :user do
      root :to => 'pages#home' , :as => :root_path
    end
    
  end

  root to: 'pages#home_logged_in'

  

  match 'tags/tag_delete' => 'tags#tag_delete', :as => :tag_delete, :via => [:get, :post]

  get '/pages/:page' => 'pages#home_logged_in'
  get '/pages/:page' => 'pages#home'

  match 'photos/licence' => 'photos#licence', :as => :licence, :via => [:get, :post]
  match 'photos/privacy-policy' => 'photos#privacy_policy', :as => :privacy_policy, :via => [:get, :post]
  match 'photos/regulations' => 'photos#regulations', :as => :regulations, :via => [:get, :post]


  match 'photos/add_like' => 'photos#add_like', :as => :add_like, :via => [:get, :post]
  match 'photos/download_photo' => 'photos#download_photo', :as => :download_photo, :via => [:get, :post]
  match 'photos/about-us' => 'photos#about_us', :as => :about_us, :via => [:get, :post]
  match 'photos/faq' => 'photos#faq', :as => :faq, :via => [:get, :post]

  match 'photos/direct-link/:hashed' => 'photos#direct_link', :as => :direct_photo, :via => [:get, :post]

  

  match 'searches/searches_results' => 'searches#searches_results', :as=> :searches_results, :via => [:get]

  match 'searches/most-popular-free-photos' => 'searches#most_popular_free_photos', :as=> :most_popular, :via => [:get, :post]

  #get 'searches/most-popular-free-photos/:page' => 'searches#most_popular_free_photos', :as => :most_popular

  resources :contacts
  resources :descriptions
  resources :unsubscribes
  resources :messages
  resources :rankings
  resources :pages
  resources :profiles
  resources :searches
  resources :photos
  resources :users
  resources :tags

end
