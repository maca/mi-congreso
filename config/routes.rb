MiCongreso::Application.routes.draw do

  devise_for :users, controllers: { :registrations => "registrations" }

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: "home#index"
  resources :members, only: [:index, :show], path: "diputados"

  match "iniciativas/temas/:subject_id" => "initiatives#index", as: :subject_initiatives
  resources :initiatives, only: [:index, :show], path: "iniciativas" do
    resources :user_votes, only: [:create]
  end

  resources :user_interests, only: [:new, :create]
end
