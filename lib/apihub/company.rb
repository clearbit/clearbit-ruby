module APIHub
  class Person < Base
    endpoint 'https://company.apihub.co'
    path '/v1/companies'

    def self.find(values, options = {})
      unless values.is_a?(Hash)
        values = {:id => values}
      end

      options = options.dup
      params  = options.delete(:params) || {}

      if domain = values[:domain]
        response = get(uri(:domain, domain), params, options)

      elsif id = values[:id]
        response = get(id, params, options)

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
  end
end