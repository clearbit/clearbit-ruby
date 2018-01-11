module Clearbit
  class Forms < Base
    autoload :Response, 'clearbit/forms/response'

    endpoint 'https://forms.clearbit.com'
    path '/v1/forms'

    def self.find(values)
      self.new(get(:find, values))
    rescue Nestful::ResourceNotFound
    end

    class << self
      alias_method :[], :find
    end
  end
end
