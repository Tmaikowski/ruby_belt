class User < ApplicationRecord
  has_secure_password
  has_one :playlist
  has_one :hub

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :email, :uniqueness => { :case_sensitive => false }, format: { with: email_regex }
  validates :password, :password_confirmation, presence: true, on: :create
  validates :password, :password_confirmation, length: { minimum: 8 }, on: :create
end
