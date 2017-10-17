Rails.application.routes.draw do

  get 'select_models', to: "forecast_sets#select_models"

  post 'select_params', to: "forecast_sets#select_params"

  get 'welcome/index'
  #resources :models
  root 'welcome#index'

  resources :products, only: [:index, :show] do
    resources :records, only: :index
  end
  
  get '/models', to: "models#select"
  get '/models/params', to: "models#select_params"
  
  namespace :upload do
    get 'file'
    post 'done'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
