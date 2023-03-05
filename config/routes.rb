Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/recipes', to: 'recipes#search'
    end
  end
end