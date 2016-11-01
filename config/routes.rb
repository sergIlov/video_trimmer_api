Rails.application.routes.draw do
  scope module: :v1, constraints: VersionConstraints.new(version: 1, default: true), defaults: {format: :json} do
    resources :users, only: :create
    resources :videos, only: [:create, :index, :show]
    resources :tasks, only: [:create, :index, :show] do
      get :restart, on: :member
    end
    
  end
end
