module Clearbit
  class Prospector < Base
    endpoint 'https://prospector.clearbit.com'
    path '/v1/people'

    def self.search(params = {})
      self.new get('search', params)
    end
  end
end
