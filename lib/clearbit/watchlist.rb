module Clearbit
  class Watchlist < Base
    endpoint 'https://watchlist.clearbit.com'
    path '/v1/search/all'

    def self.search(params, options = {})
      response = post('', params, options)
      self.new(response)
    end

    class Individual < Watchlist
      path '/v1/search/individuals'
    end

    class Entity < Watchlist
      path '/v1/search/entities'
    end
  end
end