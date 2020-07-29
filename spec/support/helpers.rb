module Spec
  module Support
    module Helpers
      def generate_signature(clearbit_key, webhook_body)
        signed_body = webhook_body
        signed_body = JSON.dump(signed_body) unless signed_body.is_a?(String)
        'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), clearbit_key, signed_body)
      end
    end
  end
end
