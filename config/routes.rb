MiCongreso::Application.routes.draw do

  match "/sections" => "sections#index"

  devise_for :users, controllers: { :registrations => "registrations" }

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: "home#index"
  resources :deputies, only: [:index, :show], path: "diputados" do
    member { get :votes }
  end

  match "iniciativas/temas/:subject_id" => "initiatives#index", as: :subject_initiatives
  resources :initiatives, only: [:index, :show], path: "iniciativas" do
    resources :user_votes, only: [:create]
  end

  resources :user_interests, only: [:new, :create]
end
