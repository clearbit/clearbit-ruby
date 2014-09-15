module Clearbit
  class PersonCompany < Base
    endpoint 'https://person.clearbit.co'
    path '/v1/combined'

    def self.find(values, options = {})
      unless values.is_a?(Hash)
        values = {:id => values}
      end

      options = options.dup
      params  = options.delete(:params) || {}

      if webhook_id = options.delete(:webhook_id)
        params.merge!(webhook_id: webhook_id)
      end

      if webhook_url = options.delete(:webhook_url)
        params.merge!(webhook_url: webhook_url)
      end

      if subscribe = options.delete(:subscribe)
        params.merge!(subscribe: subscribe)
      end

      if email = values[:email]
        response = get(uri(:email, email), params, options)
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