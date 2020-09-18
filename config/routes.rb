# frozen_string_literal: true

Rails.application.routes.draw do
  resources :debts
  resources :movements
  resources :accounts
  resources :natural_people
  resources :categories
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root(to: 'index#index')
end
