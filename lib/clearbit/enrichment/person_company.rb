module Clearbit
  module Enrichment
    class PersonCompany < Base
      endpoint 'https://person.clearbit.com'
      path '/v1/combined'

      def self.find(values)
        unless values.is_a?(Hash)
          values = {:id => values}
        end

        if email = values.delete(:email)
          response = get(uri(email), values)
        else
          raise ArgumentError, 'Invalid values'
        end

        if response.status == 202
          self.new(pending: true)
        else
          self.new(response)
        end
      rescue Nestful::ResourceNotFound
      end

      class << self
        alias_method :[], :find
      end
    end
  end
end
