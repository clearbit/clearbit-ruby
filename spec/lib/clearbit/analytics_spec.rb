require 'spec_helper'
require 'base64'

describe Clearbit::Analytics do
  before do |example|
    Clearbit.key = 'clearbit_key'
  end

  describe '#identify' do
    it 'sends an identify request to Clearbit X' do
      basic_auth = Base64.encode64('clearbit_key:').strip
      x_stub = stub_request(:post, 'https://x.clearbit.com/v1/import').
        with(
          headers: { 'Authorization' => "Basic #{basic_auth}" }
        ).to_return(status: 200, body: {success: true}.to_json)

      Clearbit::Analytics.identify(
        user_id: '123',
        traits: {
          email: 'david@clearbit.com',
        },
      )

      expect(x_stub).to have_been_requested
    end
  end

  describe '#page' do
    it 'sends an identify request to Clearbit X' do
      basic_auth = Base64.encode64('clearbit_key:').strip
      x_stub = stub_request(:post, 'https://x.clearbit.com/v1/import').
        with(
          headers: { 'Authorization' => "Basic #{basic_auth}" }
        ).to_return(status: 200, body: {success: true}.to_json)

      Clearbit::Analytics.page(
        user_id: '123',
        traits: {
          email: 'david@clearbit.com',
        },
      )

      expect(x_stub).to have_been_requested
    end
  end

  describe '#group' do
    it 'sends an identify request to Clearbit X' do
      basic_auth = Base64.encode64('clearbit_key:').strip
      x_stub = stub_request(:post, 'https://x.clearbit.com/v1/import').
        with(
          headers: { 'Authorization' => "Basic #{basic_auth}" }
        ).to_return(status: 200, body: {success: true}.to_json)

      Clearbit::Analytics.group(
        user_id: '123',
        group_id: '123',
        traits: {
          domain: 'clearbit.com',
        },
      )

      expect(x_stub).to have_been_requested
    end
  end
end
