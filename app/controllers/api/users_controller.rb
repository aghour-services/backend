class Api::UsersController < ApiController
  before_action :authenticate_user!, only: %i[profile update]
  before_action :fetch_user, only: %i[show]

  include Attachable

  def profile; end

  def show; end

  def update
    ActiveRecord::Base.transaction do
      if current_user.update(user_params)
        upload_avatar(params, current_user)
        render :update, status: :ok
      end
    rescue StandardError
      render json: { message: current_user.errors.messages }, status: :unprocessable_entity
      raise ActiveRecord::Rollback
    end
  end

  private

  def fetch_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :mobile, :password, :password_confirmation)
  end
end
