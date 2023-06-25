class AvatarRepo
    def initialize(resource, raw_response, resource_id, resource_type, url)
        @resource = resource
        @raw_response = raw_response
        @resource_type = resource_type
        @resource_type = resource_type
        @url = url
    end

    def create_avatar
        avatar = @resource.build_avatar(
            raw_response: @raw_response,
            resource_id: @resource_id,
            resource_type: @resource_type,
            url: @url
        )
        avatar.save
    end
end