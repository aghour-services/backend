# frozen_string_literal: true

class ApiController < ActionController::API
  respond_to :json

  attr_accessor :current_user

  def authenticate_user!
    self.current_user = User.find_by token: request.headers['TOKEN']
  end

  def user_ability
    @user_ability = UserAbility.new(current_user)
  end
end
