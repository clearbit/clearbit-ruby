require 'rack/utils'
require 'openssl'

module Clearbit
  module WebhookSignature
    def self.validate!(request_signature, webhook_body)
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), clearbit_key, webhook_body)

      if Rack::Utils.secure_compare(signature, request_signature)
        true
      else
        raise Errors::InvalidWebhookSignature
      end
    end

    def self.clearbit_key
      ENV['CLEARBIT_KEY'] || raise('Clearbit config error: Please make sure CLEARBIT_KEY env var is set.')
    end
  end
end
