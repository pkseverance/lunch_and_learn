Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/recipes', to: 'recipes#search'
      get '/tourist_sights', to: 'countries#search'
    end
  end
end