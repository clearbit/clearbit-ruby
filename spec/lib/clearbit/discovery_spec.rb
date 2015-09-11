require 'spec_helper'

describe Clearbit::Discovery do
  before do |example|
    Clearbit.key = 'clearbit_key'
  end

  it 'should call out to the Discovery API' do
    body  = []
    query = {query: [{name: 'stripe'}]}

    stub_request(:post, "https://discovery.clearbit.com/v1/companies/search").
      with(:headers => {'Authorization'=>'Bearer clearbit_key'}, body: query.to_json).
      to_return(:status => 200, :body => body.to_json, headers: {'Content-Type' => 'application/json'})

    Clearbit::Discovery.search(name: 'stripe')
  end
end
