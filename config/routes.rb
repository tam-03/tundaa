# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "top#index"
  get "top/index"
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  namespace "api", format: "json" do
    resources :users, only: %i(index)
  end
end
