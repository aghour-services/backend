# frozen_string_literal: true

module Api
  module Users
    class RegistrationsController < Devise::RegistrationsController
      def create
        ActiveRecord::Base.transaction do
          build_resource(user_params)
          resource_saved = resource.save
          yield resource if block_given?

          begin
            if resource_saved
              if resource.active_for_authentication?
                upload_avatar
                sign_up(resource_name, resource)
                render json: { message: 'تم انشاء الحساب بنجاح' }, status: :created
              end
            else
              clean_up_passwords resource
              set_minimum_password_length
              render json: { message: resource.errors.messages }, status: :unprocessable_entity
            end
          rescue StandardError
            render json: { message: resource.errors.messages }, status: :unprocessable_entity
            raise ActiveRecord::Rollback
          end
        end
      end

      def update
        ActiveRecord::Base.transaction do
          resource_updated = resource.update_without_password(user_params)
          yield resource if block_given?

          begin
            if resource_updated
              upload_avatar
              bypass_sign_in resource, scope: resource_name
              render json: { message: 'تم تحديث الحساب بنجاح' }, status: :ok
            else
              clean_up_passwords resource
              set_minimum_password_length
              render json: { message: resource.errors.messages }, status: :unprocessable_entity
            end
          rescue StandardError
            render json: { message: resource.errors.messages }, status: :unprocessable_entity
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :mobile, :password, :password_confirmation)
      end

      def upload_avatar
        if params[:user][:avatar].present?
          response = ImgurUploader.upload(params[:user][:avatar].tempfile.path)
          raise StandardError, 'خطأ في تحميل الصورة' unless response['success'] == true

          resource_id = response['data']['id']
          resource_type = response['data']['type']
          url = response['data']['link']
          avatar_repo = AvatarRepo.new(resource, response, resource_id, resource_type, url)
          avatar_repo.create_avatar
        end
      end
    end
  end
end
