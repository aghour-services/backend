class Like < ApplicationRecord
  include NotificationHelper

  belongs_to :user
  belongs_to :article

  validates :user_id, uniqueness: { scope: :article_id }

  after_create :send_notification

  private

  def send_notification
    sender = Notifications::Sender.new(notification_payload)
    sender.send_to_specific_users(interested_tokens)
  end

  def notification_payload
    {
      'title' => "أعجب #{user.name} بخبر #{article.user.name}",
      'body' => '',
      'like_id' => id
      'article_id' => article_id,
      'user_id' => user_id,
      'article_image' => article&.attachments&.first&.resource_url,
      'user_avatar' => user&.avatar&.url || DEFAULT_USER_ICON,
    }
  end
end
