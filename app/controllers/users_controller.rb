class UsersController < HtmlController
  before_action :fetch_user, only: %I[destroy]

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def fetch_user
    @user = User.find(params[:id])
  end
end
