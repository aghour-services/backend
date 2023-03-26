class Attachment < ApplicationRecord
    belongs_to :article

    def resource_url
        base_url = "https://i.imgur.com/"
        extension = resource_type.split("/").last
        resource_url = "#{base_url}#{resource_id}.#{extension}"
        return resource_url
    end
end
