module APIHub
  class Person < Base
    endpoint 'https://profile.apihub.co'
    path '/v1/people'

    def self.find(values, options = {})
      unless values.is_a?(Hash)
        values = {:id => values}
      end

      options = options.dup
      params  = options.delete(:params) || {}

      if email = values[:email]
        response = get(uri(:email, email), params, options)

      elsif twitter = values[:twitter]
        response = get(uri(:twitter, twitter), params, options)

      elsif github = values[:github]
        response = get(uri(:github, github), params, options)

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