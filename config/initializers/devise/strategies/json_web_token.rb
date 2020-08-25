# frozen_string_literal: true

module Devise
  module Strategies
    class JsonWebToken < Base
      def valid?
        bearer_header.present?
      end

      def authenticate!
        return if no_claims_or_no_claimed_user_id

        user = AuthUser.find_by_id(claims['auth_user_id'])
        request.params[:claims] = claims
        success! user
      end

      protected

      def bearer_header
        request.headers['Authorization'].to_s
      end

      def no_claims_or_no_claimed_user_id
        !claims || !claims.key?('auth_user_id')
      end

      private

      def claims
        @claims ||= get_claims
      end

      def get_claims
        strategy, token = bearer_header.split(' ')

        return nil if (strategy || '').downcase != 'bearer'

        begin
          JsonToken.decode(token)
        rescue StandardError
          nil
        end
      end
    end
  end
end
