Rails.application.routes.draw do
  root 'static_pages#top'

  resources :users, only: %i[new create]
  resources :password_resets, only: %i[new create edit update]
  

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  get 'home', to: 'action_selection#index', as: :home

  get 'questions', to: 'questions#index'
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
