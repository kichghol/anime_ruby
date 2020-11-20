Rails.application.routes.draw do
  root to: 'anime#index'
  get '/search' => 'anime#search'
  get '/signup' => 'anime#signup'
  get '/success' => 'anime#success'
end
