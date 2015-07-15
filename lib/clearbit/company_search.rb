module Clearbit
  class CompanySearch < Base
    endpoint 'https://company.clearbit.com'
    path '/v1/companies/search'

    def self.search(query, params = {})
      options  = params.delete(:request) || {}
      options  = options.merge(format: :json)

      query    = [query] if query.is_a?(Hash)
      params   = params.merge(query: query)

      response = post('', params, options)

      self.new(response)
    end
  end
end
