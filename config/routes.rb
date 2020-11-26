Rails.application.routes.draw do
  root to: 'anime#index'
  get '/search' => 'anime#search'
  get '/signup' => 'anime#signup'
  post '/success' => 'anime#success'
end
