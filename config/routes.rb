Rails.application.routes.draw do
  resources :categories
  resources :organisers
  resources :events
  devise_for :users, skip: [:registerable, :recoverable]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  get '/download_calendar_event', to: 'home#download_calendar_event'
end
