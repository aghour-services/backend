class Api::UsersController < ApiController
  before_action :authenticate_user!
  def profile; end
end
