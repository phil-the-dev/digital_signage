# frozen_string_literal: true

module Api
  module V1
    class AuthUserController < ApiController
      before_action :authenticate_auth_user!, only: [:sign_out]


      def register
        auth_user = AuthUser.create!(auth_user_params)
        user = User.create!(auth_user: auth_user)
        token = Token.create(auth_user: auth_user)
        token.make_token.save!
        render json: { token: token.token }
      end

      private

      def auth_user_params
        params.permit(:email, :password)
      end
    end
  end
end
