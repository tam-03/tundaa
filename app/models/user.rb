# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true
  # validates :name, presence: true

  has_many :questions, dependent: :destroy
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, omniauth_providers: %i[github]
  include DeviseTokenAuth::Concerns::User
end
