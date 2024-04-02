require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  get 'up' => 'rails/health#show', as: :rails_health_check

  # root "devise/sessions#create"

  devise_for :admins
  devise_for :users
end
