require 'spec_helper'

describe Clearbit::Prospector do
  before do |example|
    Clearbit.key = 'clearbit_key'
  end

  context 'Prospector API' do
    it 'calls the Prospector API' do
      body = { page: 1, page_size: 5, total: 723, results: [] }

      stub_request(:get, "https://prospector.clearbit.com/v1/people/search?domain=stripe.com").
        with(:headers => {'Authorization'=>'Bearer clearbit_key'}).
        to_return(:status => 200, :body => body.to_json, headers: {'Content-Type' => 'application/json'})

      Clearbit::Prospector.search(domain: 'stripe.com')
    end

    it 'can page through records' do
      body = { page: 2, page_size: 10, total: 12, results: [] }

      stub_request(:get, "https://prospector.clearbit.com/v1/people/search?domain=stripe.com&page=2&page_size=10").
        with(:headers => {'Authorization'=>'Bearer clearbit_key'}).
        to_return(:status => 200, :body => body.to_json, headers: {'Content-Type' => 'application/json'})

      Clearbit::Prospector.search(domain: 'stripe.com', page: 2, page_size: 10)
    end
  end
end
