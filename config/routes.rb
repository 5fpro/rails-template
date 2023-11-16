Rails.application.routes.draw do
  constraints Tyr.config.api_constraints do
    scope module: 'api' do
      root to: 'base#index', as: :api_root
      get '/error', to: 'base#error'
    end
  end

  constraints Tyr.config.admin_constraints || {} do
    namespace :admin do
      root to: 'base#index'
      resources :users
    end
  end

  root to: 'base#index'

  mount Tyr::Engine => '/'

  instance_exec(&Tyr.config.proc_route_404)
end
