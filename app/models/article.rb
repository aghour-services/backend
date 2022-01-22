require 'action_view'
require 'action_view/helpers'

class Article < ApplicationRecord
  include ActionView::Helpers::DateHelper

  validates :description, presence: true
  belongs_to :user, optional: true

  enum status: { draft: 0, published: 1 }, _default: :published

  def time_ago
    distance_of_time_in_words_to_now(created_at.to_datetime)
  end

end
