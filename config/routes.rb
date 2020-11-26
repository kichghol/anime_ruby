Rails.application.routes.draw do
  root to: 'anime#index'
  get '/search' => 'anime#search'
  get '/signup' => 'anime#signup'
  get '/add' => 'anime#add'

  post '/success' => 'anime#success'
  post '/add_success' => 'anime#add_success'
end
