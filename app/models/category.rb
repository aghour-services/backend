class Category < ApplicationRecord
  has_one_attached :icon
  validates :name, presence: true
  validates :icon, presence: true

  has_many :firms

  def icon_path
    icon.attachment.try(:blob).try(:url)
  end
end
