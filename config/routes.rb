# frozen_string_literal: true

Rails.application.routes.draw do
  resources :transactions, only: %i[index show create new]
  resources :debts
  resources :accounts do
    resources :movements
  end
  resources :natural_people
  resources :categories
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root(to: 'index#index')
end
