module APIHub
  class Watchlist < Base
    endpoint 'https://watchlist.apihub.co'
    path '/v1/search/all'

    def self.search(name, options = {})
      options = options.dup
      params  = options.delete(:params) || {}

      params  = {
        name:      name,
        threshold: options.delete(:threshold) || 1.0
      }.merge(params)

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