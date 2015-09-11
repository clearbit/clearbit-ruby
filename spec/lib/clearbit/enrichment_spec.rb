require 'spec_helper'

describe Clearbit::Enrichment do
  before do |example|
    Clearbit.key = 'clearbit_key'
  end

  context 'combined API' do
    it 'should call out to the combined API' do
      body = {
        person: nil,
        company: nil
      }

      stub_request(:get, "https://person.clearbit.com/v1/combined/test@example.com").
        with(:headers => {'Authorization'=>'Bearer clearbit_key'}).
        to_return(:status => 200, :body => body.to_json, headers: {'Content-Type' => 'application/json'})

      Clearbit::Enrichment.find(email: 'test@example.com')
    end
  end

  context 'person API' do
    it 'should call out to the person API' do
      body = {}

      stub_request(:get, "https://person.clearbit.com/v1/people/email/test@example.com").
        with(:headers => {'Authorization'=>'Bearer clearbit_key'}).
        to_return(:status => 200, :body => body.to_json, headers: {'Content-Type' => 'application/json'})

      Clearbit::Enrichment::Person.find(email: 'test@example.com')
    end
  end

  context 'company API' do
    it 'should call out to the company API' do
      body = {}

      stub_request(:get, "https://company.clearbit.com/v1/companies/domain/example.com").
        with(:headers => {'Authorization'=>'Bearer clearbit_key'}).
        to_return(:status => 200, :body => body.to_json, headers: {'Content-Type' => 'application/json'})

      Clearbit::Enrichment::Company.find(domain: 'example.com')
    end
  end
end
