require 'openssl'
require 'rack'
require 'json'

module Clearbit
  class Webhook < Mash
    def self.clearbit_key
      Clearbit.key!
    end

    def self.valid?(request_signature, body)
      return false unless request_signature && body

      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), clearbit_key, body)
      Rack::Utils.secure_compare(request_signature, signature)
    end

    def self.valid!(signature, body)
      valid?(signature, body) ? true : raise(Errors::InvalidWebhookSignature.new)
    end

    def initialize(env)
      request = Rack::Request.new(env)

      request.body.rewind

      signature = request.env['HTTP_X_REQUEST_SIGNATURE']
      body      = request.body.read

      self.class.valid!(signature, body)

      merge!(JSON.parse(body))
    end
  end
end
