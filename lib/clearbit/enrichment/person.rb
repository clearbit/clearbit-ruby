module Clearbit
  module Enrichment
    class Person < Base
      endpoint 'https://person.clearbit.com'
      path '/v1/people'

      def self.find(values)
        unless values.is_a?(Hash)
          values = {:id => values}
        end

        if email = values[:email]
          response = get(uri(:email, email), values)

        elsif twitter = values[:twitter]
          response = get(uri(:twitter, twitter), values)

        elsif github = values[:github]
          response = get(uri(:github, github), values)

        elsif id = values[:id]
          response = get(id, values)

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

      def flag!(attrs = {})
        self.class.post(uri('flag'), attrs)
      end
    end
  end
end
