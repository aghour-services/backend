class Attachment < ApplicationRecord
  belongs_to :article
  BASE_URL = 'https://i.imgur.com/'.freeze

  def resource_url
    extension = resource_type.split('/').last
    "#{BASE_URL}#{resource_id}.#{extension}"
  end
end
