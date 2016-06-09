Rails.application.routes.draw do
#  devise_for :users
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :estimates do
    collection do
      get 'new'
    end
  end

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

  resources :manufacture_availables, only:[:index]

  # master
  resources :map_regions, only:[:index]
  resources :map_solar_systems, only:[:index]
  resources :map_system_costs, only:[:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
