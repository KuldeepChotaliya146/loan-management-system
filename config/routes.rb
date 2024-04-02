require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'home#index'

  devise_for :admins
  devise_for :users

  scope :admin do
    get 'dashboard', to: 'dashboard#index'
  end
end
