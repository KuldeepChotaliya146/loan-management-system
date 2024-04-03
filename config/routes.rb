require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'loans#index'

  devise_for :admins
  devise_for :users

  scope :admin do
    get 'dashboard', to: 'dashboard#index'
    get ':loan_id/approve', to: 'dashboard#approve_loan', as: :admin_approve_loan
    post ':loan_id/change-status', to: 'dashboard#change_loan_status', as: :admin_request_loan
  end

  scope :users do
    resources :loans, only: %i[index new create] do
      post '/change', to: 'loans#change_loan', as: :change
      member do
        post 'repay'
      end
    end
  end
end
