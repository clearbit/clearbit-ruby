module APIHub
  class Company < Base
    endpoint 'https://company-stream.apihub.co'
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

      self.new(response)

    rescue Nestful::ResourceNotFound
    end

    class << self
      alias_method :[], :find
    end
  end
end