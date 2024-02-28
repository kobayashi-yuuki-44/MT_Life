Rails.application.routes.draw do

  root 'static_pages#top'

  resources :users, only: %i[new create]
  resources :password_resets, only: %i[new create edit update]
  resource :profile, only: %i[show edit update]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  get 'oauth/callback', to: 'oauths#callback'
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

  get 'home', to: 'action_selection#index', as: :home

  resources :questions, only: [:index, :show] do
    collection do
      get 'subject'
      get 'year'
      get 'random'
    end
    member do
      post 'answer'
    end
  end

  get 'show_subject/:subject', to: 'questions#show_subject', as: :show_subject_questions
  
  get 'notebooks', to: 'notebooks#index'
  get 'words', to: 'words#index'
  get 'messages', to: 'messages#index'
  get 'diaries', to: 'diaries#index'

  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
