Rails.application.routes.draw do
    
    resources :items  do
     resources :item_histories, only: [:index, :create] do
      end
    end
    devise_for :users,
      controllers: {
         omniauth_callbacks: 'users/omniauth_callbacks'
      }
    resources :employees do
      member do
       get :download_profile
      end
    end
  resources :documents
  get "about" => "pages#about_us"
  get "contact" => "pages#contact_us"
  get "privacy-policy" => "pages#privacy_policy"
  get "terms-and-conditions" => "pages#terms_and_conditions"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  root "home#index"
end
