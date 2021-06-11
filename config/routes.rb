# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "top#index"
  get "/home", to: "top#index"
  get "/sign_up", to: "top#index"
  get "/login", to: "top#index"
  get "/questions/new", to: "top#index"
  get "/questions", to: "top#index"
  get "/questions/:id", to: "top#index"
  get "/questions/:id/edit", to: "top#index"
  get "/templates", to: "top#index"
  get "/templates/new", to: "top#index"
  get "/templates/:id", to: "top#index"
  get "/templates/:id/edit", to: "top#index"
  get "/templates/:template_id/samples", to: "top#index"
  get "/templates/:template_id/samples/:id", to: "top#index"
  get "/templates/:template_id/samples/:id/edit", to: "top#index"
  namespace "api" do
    mount_devise_token_auth_for "User", at: "auth"
    resources :questions, except: %i(new edit)
    resources :templates, except: %i(new edit) do
      resources :samples, except: %i(new edit)
    end
  end
end
