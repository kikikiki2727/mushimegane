Rails.application.routes.draw do
  root 'top#home'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
  resources :users, only: %i[new create]
  resources :bugs do
    resource :radar_chart, only: %i[new create edit update]
    resources :comments, only: %i[create destroy], shallow: true do
      resources :likes, only: %i[create destroy]
    end
  end
end
