# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for "User", at: "auth"
  root to: "top#index"
  get "top/index"
end
