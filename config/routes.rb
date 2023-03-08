Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/recipes', to: 'recipes#search'
      get '/tourist_sights', to: 'countries#search'
      get '/learning_resources', to: 'learning_resources#search'

      resources :users, only: [:create]
      resources :favorites, only: [:create]
    end
  end
end