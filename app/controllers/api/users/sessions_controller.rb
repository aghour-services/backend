# frozen_string_literal: true

class Api::Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    warden.authenticate!(scope: resource_name, recall: "#{controller_path}#new")
    current_user.generate_token
    current_user.save
    current_user.reload
    render json: current_user, status: 200
  end
end
