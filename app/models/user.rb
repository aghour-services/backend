class User < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :generate_token

  def generate_token
    self.token = id.to_s + '/' + SecureRandom.urlsafe_base64(nil, false)
  end
end
