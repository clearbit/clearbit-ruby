require 'spec_helper'

describe Clearbit::Webhook do
  before do |example|
    Clearbit.key = 'clearbit_key'
  end

  context 'valid signature' do
    it 'returns true' do
      signature = generate_signature('A-OK')

      result = Clearbit::Webhook.valid!(signature, 'A-OK')

      expect(result).to eq true
    end
  end

  context 'invalid signature' do
    it 'returns false' do
      signature = generate_signature('A-OK')

      expect {
        Clearbit::Webhook.valid!(signature, 'TAMPERED_WITH_BODY_BEWARE!')
      }.to raise_error(Clearbit::Errors::InvalidWebhookSignature)
    end
  end

  context 'initialize' do
    it 'returns a mash' do
      request_body = JSON.dump({
        id:   '123',
        type: 'person',
        body: nil,
        status: 404
      })

      request_signature = generate_signature(request_body)

      env = Rack::MockRequest.env_for('/webhook',
        method: 'POST',
        input:  request_body,
        'HTTP_X_REQUEST_SIGNATURE' => request_signature
      )

      webhook = Clearbit::Webhook.new(env)

      expect(webhook.status).to eq 404
    end
  end

  def generate_signature(webhook_body)
    'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), 'clearbit_key', webhook_body)
  end
end
