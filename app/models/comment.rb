require 'action_view'
require 'action_view/helpers'
class Comment < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :article

  after_create :send_notification

  def time_ago
    distance_of_time_in_words_to_now(created_at.to_datetime)
  end

  def send_notification
    NotificationService.new(notification_payload, interested_tokens).send_to_custom
  end

  def interested_tokens
    # Need more handle
    # user article owner and user article liked and user article comment in one array
    tokens = []
    tokens << article.user.devices.pluck(:token)
    tokens << article.likes.pluck(:user_id)
    tokens << article.comments.pluck(:user_id)
    tokens.flatten.uniq
  end
 
  def notification_payload
    message_title = 'تعليق جديد'
    {
      'title' => message_title,
      'body' => body.first(500),
      'comment_id' => id,
      'article_id' => article_id,
      'user_id' => user_id,
    }
  end
end
