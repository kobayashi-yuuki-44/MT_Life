Rails.application.routes.draw do
  root 'static_pages#top'

  get 'home', to: 'action_selection#index', as: 'home'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'questions', to: 'questions#index'
  get 'notebooks', to: 'notebooks#index'
  get 'words', to: 'words#index'
  get 'messages', to: 'messages#index'
  get 'diaries', to: 'diaries#index'
end
