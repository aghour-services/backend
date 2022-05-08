# frozen_string_literal: true

class UserAbility
  def new(user)
    @user = user
  end

  def can_publish?
    @user.role = :publisher || @user.admin?
  end
end
