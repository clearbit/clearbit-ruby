module Clearbit
  class Audiences < Base
    endpoint 'https://audiences.clearbit.com'
    path '/v1/audiences'

    def self.add_email(values = {})
      post('email', values)
    end

    def self.add_domain(values = {})
      post('domain', values)
    end
  end
end
