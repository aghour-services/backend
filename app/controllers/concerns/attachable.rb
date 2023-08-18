module Attachable
    extend ActiveSupport::Concern
    
    def upload_avatar(params, resource)
        if params[:user][:avatar].present?
            response = ImgurUploader.upload(params[:user][:avatar].tempfile.path)
            raise StandardError, 'خطأ في تحميل الصورة' unless response['success'] == true
    
            resource_id = response['data']['id']
            resource_type = response['data']['type']
            url = response['data']['link']
            avatar_repo = AvatarRepo.new(resource, response, resource_id, resource_type, url)
            avatar_repo.create
        end
    end

    def upload_article_attachment(params, resource)
        if params[:article][:attachment].present?
            response = ImgurUploader.upload(params[:article][:attachment].tempfile.path)
            raise StandardError, 'خطأ في تحميل الصورة' unless response['success'] == true
    
            resource_id = response['data']['id']
            resource_type = response['data']['type']
            attachment_repo = AttachmentRepo.new(resource, response, resource_id, resource_type)
            resource.attachments.destroy_all
            attachment_repo.create
        end
    end
end