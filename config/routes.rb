Rails.application.routes.draw do

  root 'static_pages#top'

  resources :users  do
    resource :profile, only: [:show], controller: 'profiles'
  end

  resource :profile, only: %i[show edit update], controller: 'profiles'

  mount ActionCable.server => '/cable'
  
  resources :rooms do
    resources :direct_messages, only: [:create]
  end
  
  resources :password_resets, only: %i[new create edit update]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  get 'oauth/callback', to: 'oauths#callback'
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

  get 'home', to: 'action_selection#index', as: :home

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :questions, only: [:index, :show] do
    collection do
      get 'subject'
      get 'year'
      get 'random'
      get 'next_random'
    end
    member do
      post 'answer'
    end
    resources :memos, only: [:create, :update]
  end

  get 'show_subject/:subject', to: 'questions#show_subject', as: :show_subject_questions
  get 'show_year/:year', to: 'questions#show_year', as: :show_year_questions

  resources :notebooks do
    resources :pages, param: :page_number do
      member do
        patch 'save_content'
      end
    end
  end

  resources :wordbooks do
    member do
      get 'card'
    end
    resources :words
  end
  
  resources :posts, only: [:index, :new, :create]
  
  resources :diaries do
    collection do
      get 'calendar'
      get 'titles', to: 'diaries#index', as: 'titles'
    end
  end

  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
