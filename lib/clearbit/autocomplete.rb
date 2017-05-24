module Clearbit
  class Autocomplete < Base
    endpoint 'https://autocomplete.clearbit.com'
    path '/v1'

    def self.suggest(query)
      response = get 'companies/suggest', query: query

      self.new(response)
    end
  end
end
