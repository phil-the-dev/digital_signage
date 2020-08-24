# frozen_string_literal: true

module Api
  module V1
    class UserController < ApiController
      def kiosks
        kiosks = current_user.kiosks.map { |k| { name: k.name, id: k.id } }
        render json: {
          kiosks: kiosks
        }
      end

      def current_user
        @current_user ||= User.find(params[:id])
      end
    end
  end
end
