# frozen_string_literal: true

class AuthUsers::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :authenticate_auth_user!, only: [:sign_out]
  skip_before_action :verify_authenticity_token

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)

    sign_in(resource_name, resource)

    respond_to do |format|
      if @auth_user
        format.html { respond_with resource, location: after_sign_in_path_for(resource) }

        format.json do
          token = Token.create(auth_user: @auth_user)
          token.make_token.save!
          render json: { token: token.token }
        end
      end
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super do |_resource|
      Token.where(token: bearer_token).destroy_all if bearer_token
    end
  end

  protected

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header&.match(pattern)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
