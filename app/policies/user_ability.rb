# frozen_string_literal: true

class UserAbility
  def initialize(user)
    @user = user
  end

  def can_publish?
    @user.publisher? || @user.admin?
  end
end
