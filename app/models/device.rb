class Device < ApplicationRecord
  validates :device_id, presence: true, uniqueness: true
  validates :token, presence: true
end
