Delayed::Web::Engine.routes.draw do
  root to: 'jobs#index'

  resources :jobs, only: [:destroy, :index, :show] do
    put :queue, on: :member
  end
  post 'destroy_all', to: 'jobs#destroy_all', as: :destroy_all_jobs
end
