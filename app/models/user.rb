class User < ActiveRecord::Base
  has_secure_password
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret
  validates :name, presence: true
  validates :password, :password_confirmation, presence: true, on: [:create]
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, :uniqueness => {case_sensitive: false}, :format => { :with => email_regex }
  validates :password_digest, confirmation: true
end
