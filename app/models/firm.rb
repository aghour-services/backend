class Firm < ApplicationRecord
  validates :name, :phone_number, :address, presence: true

  belongs_to :category

  include PgSearch::Model
  pg_search_scope :search, against: %i[name description],
                           using: { tsearch: { any_word: true, prefix: true, dictionary: 'arabic' } }
end
