# frozen_string_literal: true

class Firm < ApplicationRecord
  validates :name, :phone_number, :address, presence: true

  belongs_to :category
  belongs_to :user, optional: true
  has_many :ratings, dependent: :destroy
  enum status: { draft: 0, published: 1 }, _default: :draft

  scope :filter_by, ->(tags) { search_by_tags(tags.split(',')) if tags.present? }

  include PgSearch::Model
  pg_search_scope :search, against: %i[name description],
                           using: { tsearch: { any_word: true, prefix: true, dictionary: 'arabic' } }

  pg_search_scope :search_by_tags, against: %i[tags],
                                   using: { tsearch: { any_word: true, prefix: true } }
end
