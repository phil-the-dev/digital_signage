# frozen_string_literal: true

module Api
  module V1
    class UserController < ApiController
      before_action :authenticate_auth_user!

      def kiosks
        kiosks = current_auth_user.user.kiosks.map { |k| { name: k.name, id: k.id } }
        render json: { kiosks: kiosks }
      end
    end
  end
end
