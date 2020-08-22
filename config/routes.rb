# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    resources :posts do
      member do
        get '/like', to: 'likes#like'
        get '/unlike', to: 'likes#unlike'
        get '/likes', to: 'likes#likes'
      end
    end
    resources :followers, only: %i[index destroy update]
  end

  post '/login', to: 'users#login'
  post '/signup', to: 'users#create'
end
