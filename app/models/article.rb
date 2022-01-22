class Article < ApplicationRecord
  validates :description, presence: true
  belongs_to :user, optional: true

  enum status: { draft: 0, published: 1 }, _default: :published
end
