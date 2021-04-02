Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items
  
#  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
end
