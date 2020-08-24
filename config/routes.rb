Rails.application.routes.draw do
  devise_for :auth_users
  root 'pages#index'
  get '/link', to: 'pages#link'
  post '/link', to: 'pages#link_kiosk', as: :user_kiosks

  get '/kiosks', to: 'pages#kiosks'

  namespace :api do
    namespace :v1 do
      resources :playlists
    end
  end

  namespace :admin do
    resources :shows
    resources :episodes
    resources :segments
    resources :playlists
    resources :playlist_playables
  end

  resources :kiosk, only: [:index, :show] do
    collection do
      get :link
      post :link, to: 'pages#link_kiosk', as: :link_kiosk
    end
    member do
      get :authenticate
    end
  end
  namespace :kiosk do
    [:shows, :episodes, :segments].each do |playable|
      resources playable, only: [] do
        member do
          get :play
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
