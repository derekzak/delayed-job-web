Delayed::Web::Engine.routes.draw do
  root to: 'jobs#index'

  resources :jobs, only: [:destroy, :destroy_all, :index, :show] do
    put :queue, on: :member
  end
end
