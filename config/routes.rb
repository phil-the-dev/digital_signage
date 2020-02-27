Rails.application.routes.draw do
  devise_for :auth_users
  root 'pages#index'
  get '/link', to: 'pages#link'
  post '/link', to: 'pages#link_kiosk', as: :user_kiosks

  namespace :admin do
    resources :shows
    resources :episodes
    resources :segments
  end

  resources :kiosk, only: [:index, :show] do
    collection do
      [:shows, :episodes, :segments].each do |playable|
        resources playable, only: [] do
          member do
            get :play
          end
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
