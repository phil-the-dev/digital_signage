Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/index'
  namespace :admin do
  resources :shows
  resources :episodes
  resources :segments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
