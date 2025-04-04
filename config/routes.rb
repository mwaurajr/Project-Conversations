Rails.application.routes.draw do
  devise_for :users

  root to: "projects#index"

  resources :projects do
    resources :comments, only: [:create, :destroy]
    member do
      patch :update_status
    end
  end

  resources :comments, only: [] do
    resources :likes, only: [:create]
    resource :like, only: [:destroy]
  end

  resources :notifications, only: [:index] do
    post :mark_as_read, on: :member
    post :mark_all_as_read, on: :collection
  end
end
