# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "top#index"
  get "/login", to: "top#index"
  get "/sign_up", to: "top#index"
  namespace "api" do
    mount_devise_token_auth_for "User", at: "auth"
  end
end
