Rails.application.routes.draw do
  root to: 'anime#index'
  get '/search' => 'anime#search'
end
