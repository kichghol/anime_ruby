Rails.application.routes.draw do
  root to: 'anime#index'
  get '/search' => 'anime#search'
  get '/signup' => 'anime#signup'
  get '/add' => 'anime#add'

  post '/add_success' => 'anime#add_success'
  get '/signin' => 'anime#signin'
  post '/success' => 'anime#success'
  post '/signinSuccess' => 'anime#signinSuccess'

  delete '/destroy' => 'anime#destroy'
end
