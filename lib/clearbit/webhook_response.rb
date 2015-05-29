module Clearbit
  module WebhookResponse
    def initialize(request)
      request.body.rewind
      request_signature = request.env['HTTP_X_REQUEST_SIGNATURE']
      request_body = request.body.read

      WebhookSignature.validate!(request_signature, request_body)

      Mash.new(JSON.parse(request_body))
    end
  end
end
