class AttachmentRepo
    def initialize(article, raw_response, resource_id, resource_type)
        @article = article
        @raw_response = raw_response
        @resource_id = resource_id
        @resource_type = resource_type
    end

    def create
        attachment = @article.attachments.create(
            raw_response: @raw_response, 
            resource_id: @resource_id, 
            resource_type: @resource_type)
        resource_url = attachment.resource_url   
    end
end

