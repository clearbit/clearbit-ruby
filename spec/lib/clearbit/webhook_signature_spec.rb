require 'spec_helper'

describe Clearbit::WebhookSignature, '.valid?' do
  context 'valid HMAC signature' do
    it 'returns true' do
      signature = generate_signature('A-OK')

      result = Clearbit::WebhookSignature.valid?(signature, 'A-OK')

      expect(result).to eq true
    end
  end

  context 'invalid HMAC signature' do
    it 'returns false' do
      signature = generate_signature('A-OK')

      result = Clearbit::WebhookSignature.valid?(signature, 'TAMPERED_WITH_BODY_BEWARE!')

      expect(result).to eq false
    end
  end

  around do |example|
    ClimateControl.modify CLEARBIT_KEY: 'clearbit_key' do
      example.run
    end
  end

  def generate_signature(webhook_body)
    'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), 'clearbit_key', webhook_body)
  end
end
