class User < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  has_many :firms
  before_create :generate_token

  def generate_token
    self.token = "#{id}/#{SecureRandom.urlsafe_base64(nil, false)}"
  end
end
