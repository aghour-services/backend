require 'action_view'
require 'action_view/helpers'
class Comment < ApplicationRecord
  include ActionView::Helpers::DateHelper
  include NotificationHelper

  belongs_to :user
  belongs_to :article
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  after_create :send_notification, :create_notification_record

  def time_ago
    distance_of_time_in_words_to_now(created_at.to_datetime)
  end

  def send_notification
    sender = Notifications::Sender.new(notification_payload)
    sender.send_to_specific_users(interested_tokens)
  end
 
  private

  def notification_payload
    {
      'title' => "علًّقَ #{user.name} على خبر #{article.user.name}",
      'body' => body.first(500),
      'comment_id' => id,
      'article_id' => article_id,
      'user_id' => user_id,
      'article_image' => article&.attachments&.first&.resource_url,
      'user_avatar' => user&.avatar&.url || DEFAULT_USER_ICON
    }
  end

  def create_notification_record
    notification_repo = NotificationRepo.new(
      self,
      user,
      "علًّقَ #{user.name} على خبر #{article.user.name}",
      body,
      article&.attachments&.first&.resource_url
    )
    notification_repo.create
  end
end
