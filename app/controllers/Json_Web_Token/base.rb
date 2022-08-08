# frozen_string_literal: true

module JsonWebToken
  class Base
    SECRET = ENV.fetch('JWT_TOKEN', nil)

    def self.encode(payload)
      JWT.encode(payload, SECRET)
    end

    def self.decode(token)
      JWT.decode(token, SECRET)
    rescue StandardError
      nil
    end
  end
end
