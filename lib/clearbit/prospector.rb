module Clearbit
  class Prospector < Base
    endpoint 'https://prospector.clearbit.com'
    path '/v1/people'

    def self.search(values = {})
      self.new get('search', values)
    end
  end
end
