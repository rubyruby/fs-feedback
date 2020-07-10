Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :feedbacks, only: [:new, :create]

  namespace :admin do
    resources :feedbacks, only: [:index]
  end

  root to: "pages#home"
end
