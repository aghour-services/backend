class User < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :mobile, presence: true, uniqueness: true

  before_create :generate_token

  def email_required?
    false
  end

  protected

  def generate_token
    self.token = loop do
      token = SecureRandom.urlsafe_base64(nil, false)
      break token unless User.exists?(token: token)
    end
  end
end
