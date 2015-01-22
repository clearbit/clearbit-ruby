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

    class Candidate < Watchlist
      path '/v1/candidates'

      def self.find(id, options = {})
        response = get(id, {}, options)
        self.new(response)
      end

      def self.all(options = {})
        response = get('', {}, options)
        self.new(response)
      end

      def self.create(params, options = {})
        response = post('', params, options)
        self.new(response)
      end

      def destroy
        self.class.delete(id)
      end
    end
  end
end
