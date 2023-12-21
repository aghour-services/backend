# frozen_string_literal: true

class Category < ApplicationRecord
  has_one_attached :icon, dependent: :destroy
  validates :name, presence: true
  validates :icon, presence: true

  has_many :firms

  def icon_path
    return '' if icon.nil?

    icon.attachment.try(:blob).try(:url)
  rescue StandardError => e
    ''
  end
end
