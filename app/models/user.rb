# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  has_many :firms
  has_many :articles
  has_many :comments, dependent: :destroy

  before_create :generate_token

  enum role: { user: 0, publisher: 1, admin: 2 }, _default: :user

  def generate_token
    self.token = "#{id}/#{SecureRandom.urlsafe_base64(nil, false)}"
  end

  def display
    "#{name}"
  end
end
