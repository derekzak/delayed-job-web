Delayed::Web::Engine.routes.draw do
  root to: 'jobs#index'

  resources :jobs, only: [:destroy, :index, :show] do
    put :queue, on: :member
  end
  post 'destroy_all', to: 'jobs#destroy_all', as: :destroy_all_jobs
  post 'start_worker_daemon', to: 'jobs#start_worker_daemon', as: :start_jobs_worker_daemon
  post 'stop_worked_daemon', to: 'jobs#stop_worker_daemon', as: :stop_jobs_worker_daemon
end
