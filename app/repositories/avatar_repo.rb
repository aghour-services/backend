class AvatarRepo
    def initialize(resource, raw_response, avatar_id, avatar_type, avatar_url)
        @resource = resource
        @raw_response = raw_response
        @avatar_id = avatar_id
        @avatar_type = avatar_type
        @avatar_url = avatar_url
    end

    def create_avatar
        avatar = @resource.build_avatar(
            raw_response: @raw_response,
            avatar_id: @avatar_id,
            avatar_type: @avatar_type,
            avatar_url: @avatar_url
        )
        avatar.save
    end
end