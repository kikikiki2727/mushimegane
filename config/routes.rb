Rails.application.routes.draw do
  root 'static_pages#top'

  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # resources :users, only: %i[new create]
  resources :search_images, only: %i[new create]
  resources :bugs do
    post 'image_search', to: 'bugs#image_search', on: :collection
    get 'comments/sort', to: 'comments#sort'
    resource :radar_chart, only: %i[new create edit update]
    resources :comments, only: %i[create destroy], shallow: true do
      resources :likes, only: %i[create destroy]
    end
  end
end
