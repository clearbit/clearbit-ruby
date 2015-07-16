module Clearbit
  class CompanySearch < Base
    endpoint 'https://company.clearbit.com'
    path '/v1/companies/search'

    class PagedResult < Delegator
      def initialize(params, response)
        @params = params
        super Mash.new(response)
      end

      def __getobj__
        @response
      end

      def __setobj__(obj)
        @response = obj
      end

      def each(&block)
        return enum_for(:each) unless block_given?

        results.each do |result|
          yield result
        end

        if results.any?
          search = CompanySearch.search(
            @params[:query],
            @params.merge(page: page + 1)
          )
          search.each(&block)
        end
      end
    end

    def self.search(query, params = {})
      options  = params.delete(:request) || {}
      options  = options.merge(format: :json)

      query    = [query] if query.is_a?(Hash)
      params   = params.merge(query: query)

      response = post('', params, options)

      PagedResult.new(params, response)
    end
  end
end
