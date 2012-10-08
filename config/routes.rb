MiCongreso::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: "home#index"
  resources :members, only: [:index, :show], path: "diputados"
  resources :initiatives, only: [:index, :show], path: "iniciativas"
end
