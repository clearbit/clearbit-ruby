module Clearbit
  class Prospector < Base
    endpoint 'https://prospector.clearbit.com'
    path '/v1/people'

    def self.search(values = {})
      self.new get('search', values)
    end

    def email
      email_response.email
    end

    def verified?
      email_response.verified
    end

    protected

    def email_response
      @email_response ||= begin
        response = self.class.get(uri(:email))
        Mash.new(response.decoded)
      end
    end
  end
end
