require 'action_view'
require 'action_view/helpers'
class Comment < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :article
  
  has_many :notifications, as: :notifiable, dependent: :destroy

  after_create :send_notification, :create_notification_record

  def time_ago
    distance_of_time_in_words_to_now(created_at.to_datetime)
  end

  def send_notification
    NotificationService.new(notification_payload).send_to_custom(interested_tokens)
  end

  def interested_tokens
    tokens = []

    user_comment_owner = user&.devices&.last&.token

    # get article owner
    article_owner = article&.user&.devices&.last&.token
    
    # # get all users who commented on this article 
    users = article&.comments&.map(&:user)&.uniq
    devices = users&.map(&:devices)&.flatten
    commented_users_tokens = devices&.map(&:token)

    # # get all users who liked this article
    users = article&.likes&.map(&:user)&.uniq
    devices = users&.map(&:devices)&.flatten
    liked_users_tokens = devices&.map(&:token)

    tokens << article_owner << commented_users_tokens << liked_users_tokens
    tokens.flatten.reject { |token| token == user_comment_owner }.compact.uniq
  end
 
  def notification_payload
    {
      'title' => "تعليق جديد بواسطة #{user.name}",
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
      "تعليق جديد بواسطة #{user.name}",
      body,
      article&.attachments&.first&.resource_url
    )
    notification_repo.create
  end
end
