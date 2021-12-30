class Firm < ApplicationRecord
  validates :name, :phone_number, :address, presence: true

  belongs_to :category
  belongs_to :user, optional: true
  enum status: { draft: 0, published: 1 }, _default: :draft

  include PgSearch::Model
  pg_search_scope :search, against: %i[name description],
                           using: { tsearch: { any_word: true, prefix: true, dictionary: 'arabic' } }

  def dispaly_user
    "#{user.try(:id)} - #{user.try(:name)}"
  end
end
