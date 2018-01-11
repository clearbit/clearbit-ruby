module Clearbit
  module Forms
    class Response < Base
      endpoint 'https://forms.clearbit.com'
      path '/v1/responses'

      def self.create(values)
        new post(uri(''), values)
      end
    end
  end
end
