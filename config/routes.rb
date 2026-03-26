Rails.application.routes.draw do
  resources :jobs, only: [:index, :create]
  get '/jobs/search', to: 'jobs#search'

  # Frontend が叩くことを想定したカテゴリ一覧エンドポイント
  get '/categories', to: 'categories#index'

  namespace :api do
    get '/categories', to: 'categories#index'

    # Frontend が叩くことを想定した求人関連エンドポイント
    resources :jobs, only: [:index, :create]
    get '/jobs/search', to: 'jobs#search'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end