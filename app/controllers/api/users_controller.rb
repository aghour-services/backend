class Api::UsersController < ApiController
  before_action :authenticate_user!
  def profile; end

  def update
    ActiveRecord::Base.transaction do
      if current_user.update(user_params)
        upload_avatar
        render json: { message: 'تم تحديث الحساب بنجاح' }, status: :ok
      end
    rescue StandardError
      render json: { message: current_user.errors.messages }, status: :unprocessable_entity
      raise ActiveRecord::Rollback
    end
  end

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
      avatar_repo = AvatarRepo.new(current_user, response, resource_id, resource_type, url)
      avatar_repo.create
    end
  end
end
