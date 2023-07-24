# frozen_string_literal: true

require 'action_view'
require 'action_view/helpers'

class Article < ApplicationRecord
  include ActionView::Helpers::DateHelper
  CACHE_KEY = 'articles#index'

  validates :description, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments

  enum status: { draft: 0, published: 1 }, _default: :draft
  after_create :send_notification, :clear_cache

  def liked?(current_user)
    return false unless current_user

    likes.where(user_id: current_user.id).exists?
  end

  def time_ago
    distance_of_time_in_words_to_now(created_at.to_datetime)
  end

  def send_notification
    return unless published?

    NotificationService.new(self).send
  end

  def clear_cache
    REDIS_CLIENT.del CACHE_KEY
  rescue StandardError => e
  end
end
