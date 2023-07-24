# frozen_string_literal: true

# rubocop:disable Style/Documentation

class UsersController < HtmlController
  before_action :fetch_user, only: %I[edit update destroy]

  def index
    @users = User.all.includes(:avatar).order(id: :desc)
  end

  def edit; end

  def destroy
    redirect_to users_path, alert: 'Deleted User' if @user.destroy
  end

  def update
    @user.update(user_params)
    redirect_to edit_user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

  def fetch_user
    @user = User.find(params[:id])
  end
end
