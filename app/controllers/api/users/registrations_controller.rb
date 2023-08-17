# frozen_string_literal: true

module Api
  module Users
    class RegistrationsController < Devise::RegistrationsController
      include Attachable
      
      def create
        ActiveRecord::Base.transaction do
          build_resource(user_params)
          saved = resource.save
          yield resource if block_given?

          begin
            if saved
              if resource.active_for_authentication?
                upload_avatar(params, resource)
                sign_up(resource_name, resource)
                render 'api/users/create', status: :created
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

      private

      def user_params
        params.require(:user).permit(:name, :email, :mobile, :password, :password_confirmation)
      end
    end
  end
end
