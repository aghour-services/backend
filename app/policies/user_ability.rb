# frozen_string_literal: true

class UserAbility
  def initialize(user, resource:)
    @user = user
    @resource = resource
  end

  def can_publish?
    @user.publisher? || @user.admin?
  end

  def can_update?
    admin_user? || resource_owner?
  end

  def can_destroy?
    admin_user? || resource_owner?
  end

  private

  def resource_owner?
    @user == @resource.user
  end

  def admin_user?
    @user.admin?
  end
end
