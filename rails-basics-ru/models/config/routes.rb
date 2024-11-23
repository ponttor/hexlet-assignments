# frozen_string_literal: true

Rails.application.routes.draw do
  get 'articles/index'
  get 'articles/show'
  root 'home#index'
  # BEGIN
  resources :articles, only: %i[index show]
  # END
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
