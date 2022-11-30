require 'action_view'
require 'action_view/helpers'
class Comment < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :article

  def time_ago
    distance_of_time_in_words_to_now(created_at.to_datetime)
  end
end
