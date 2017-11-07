Rails.application.routes.draw do
  
  get 'login', to: "users#login"

  # Términos y condiciones
  get 'terms', to: 'welcome#term'

  # Ruta de autenticación de Oauth
  get '/auth/:provider/callback', to: 'sessions#create'
  
  delete '/logout', to: 'sessions#destroy'

  get 'predict/:id', to: "forecast_sets#select_models", as: "predict"
  
  get 'predict/:id/params', to: "forecast_sets#select_params", as: "predict_select_params"
  
  get 'results', to: "forecast_sets#index", as: "results"
  
  post 'results', to: "forecast_sets#create", as: "new_results", param: [:product_id, :model_ids]
  
  get 'results/:id/', to: "forecast_sets#show", as: "result"
  
  #get 'select_models', to: "forecast_sets#select_models"

  #post 'select_params', to: "forecast_sets#select_params"

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
