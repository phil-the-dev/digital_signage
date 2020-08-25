# frozen_string_literal: true

module JsonToken
  module_function

  ALG = 'HS256'
  SEC = ENV['JWT_SECRET']

  def encode(payload, _expiration = nil)
    # expiration ||= Rails.application.secrets.jwt_expiration_hours
    # payload = payload.dup
    # payload['exp'] = expiration.to_i.hours.from_now.to_i

    JWT.encode payload, SEC, ALG
  end

  def decode(token)
    decoded_token = JWT.decode token, SEC, ALG
    decoded_token.first
  rescue StandardError
    nil
  end
end
