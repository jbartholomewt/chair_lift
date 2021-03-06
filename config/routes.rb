Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
    authenticated :user do
      namespace :api do
        resources :lifts, only: [:index]
      end
      resources :lifts
      root 'lifts#index', as: :authenticated_root
    end


    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
