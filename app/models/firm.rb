class Firm < ApplicationRecord
  validates :name, :phone_number, :address, presence: true

  belongs_to :category
end
