require 'spec_helper'

describe Clearbit::Logo do
  context 'domain validation' do

    def check_valid_domain(domain)
      expect {
        Clearbit::Logo.url({
          domain: domain
        })
      }.not_to raise_error
    end

    def check_invalid_domain(domain)
      expect {
        Clearbit::Logo.url({
          domain: domain
        })
      }.to raise_error(ArgumentError)
    end

    it 'passes for simple domains' do
      check_valid_domain('clearbit.com')
    end

    it 'passes for dashed domains' do
      check_valid_domain('clear-bit.com')
      check_valid_domain('clear--bit.com.uk')
    end

    it 'passes for multi-dot TLDs' do
      check_valid_domain('bbc.co.uk')
      check_valid_domain('clear-bit.co.uk')
    end

    it 'fails for invalid urls' do
      check_invalid_domain('clearbit.verylongtld')
    end
  end
end
