# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :memories, only: %i[index show create]
    resources :users, only: :create
    resource :session, only: :create
  end
end
