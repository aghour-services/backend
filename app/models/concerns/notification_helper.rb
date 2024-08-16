# app/models/concerns/notification_helper.rb
module NotificationHelper
  extend ActiveSupport::Concern

  def interested_tokens
    tokens = []

    # Collect tokens from the article owner
    article_owner_token = article_owner_token
    tokens << article_owner_token if article_owner_token

    # Collect tokens from users who commented on the article
    commented_users_tokens = users_tokens_from_comments
    tokens.concat(commented_users_tokens)

    # Collect tokens from users who liked the article
    liked_users_tokens = users_tokens_from_likes
    tokens.concat(liked_users_tokens)

    # Remove the token of the user who commented
    tokens.reject! { |token| token == user_comment_owner_token }

    tokens.compact.uniq
  end

  private

  def article_owner_token
    article&.user&.devices&.map(&:token)
  end

  def user_comment_owner_token
    user&.devices&.last&.token
  end

  def users_tokens_from_comments
    users = article&.comments&.map(&:user)&.uniq
    devices = users&.map(&:devices)&.flatten
    devices&.map(&:token)
  end

  def users_tokens_from_likes
    users = article&.likes&.map(&:user)&.uniq
    devices = users&.map(&:devices)&.flatten
    devices&.map(&:token)
  end
end
