module Clearbit
  class Company < Base
    endpoint 'https://company.clearbit.com'
    path '/v1/companies'

    def self.find(values, old_options = nil)
      unless values.is_a?(Hash)
        values = {:id => values}
      end

      if old_options
        # Deprecated API
        warn '[DEPRECATION] passing multiple args to find() is deprecated'
        values.merge!(old_options)
      end

      options = values.delete(:request) || {}
      params  = values.delete(:params) || {}

      if webhook_id = values.delete(:webhook_id)
        params.merge!(webhook_id: webhook_id)
      end

      if webhook_url = values.delete(:webhook_url)
        params.merge!(webhook_url: webhook_url)
      end

      if subscribe = values.delete(:subscribe)
        params.merge!(subscribe: subscribe)
      end

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

    def flag!(attrs = {})
      self.class.post(uri('flag'), attrs)
    end
  end
end
