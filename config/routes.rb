Rails.application.routes.draw do
  resources :estimates
  resources :estimate_blueprints do
    collection do
      get 'new'
    end
  end

  resources :estimate_job_costs do
    collection do
      get 'new'
    end
  end

  resources :estimate_materials do
    collection do
      get 'new'
    end
  end

  resources :sell_orders, only:[:show] do
    collection do
      get 'get_jita_lower_price'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
