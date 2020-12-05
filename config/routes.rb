# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :transactions, only: %i[index show create new]
  resources :debts
  resources :accounts do
    resources :movements
  end
  resources :natural_people
  resources :categories
  get('/dashboard', to: 'dashboard#index')
  get('/dashboard/:id', to: 'dashboard#show', as: :account_dashboard)
  resources :users, only: %i[index destroy] do
    get :enable, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root(to: 'index#index')
end
