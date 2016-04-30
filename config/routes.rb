Rails.application.routes.draw do
  resources :estimates
  resources :estimate_blueprints
  resources :estimate_job_costs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
