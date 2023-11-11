require 'action_view'
require 'action_view/helpers'
class Comment < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :article
  
  has_many :notifications, as: :notifiable, dependent: :destroy

  def time_ago
    distance_of_time_in_words_to_now(created_at.to_datetime)
  end
end
