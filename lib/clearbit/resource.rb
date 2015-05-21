require 'uri'

module Clearbit
  class Resource < Mash
    def self.endpoint(value = nil)
      @endpoint = value if value
      return @endpoint if @endpoint
      superclass.respond_to?(:endpoint) ? superclass.endpoint : nil
    end

    def self.path(value = nil)
      @path = value if value
      return @path if @path
      superclass.respond_to?(:path) ? superclass.path : nil
    end

    def self.options(value = nil)
      @options ||= {}
      @options.merge!(value) if value

      if superclass.respond_to?(:options)
        Nestful::Helpers.deep_merge(superclass.options, @options)
      else
        @options
      end
    end

    class << self
      alias_method :endpoint=, :endpoint
      alias_method :path=, :path
      alias_method :options=, :options
      alias_method :add_options, :options
    end

    def self.url
      URI.join(endpoint.to_s, path.to_s).to_s
    end

    def self.uri(*parts)
      # If an absolute URI already
      if (uri = parts.first) && uri.is_a?(URI)
        return uri if uri.host
      end

      URI.parse(Nestful::Helpers.to_path(url, *parts))
    end

    def self.get(action = '', params = {}, options = {})
      request(uri(action), options.merge(method: :get, params: params))
    end

    def self.put(action = '', params = {}, options = {})
      request(uri(action), options.merge(method: :put, params: params))
    end

    def self.post(action = '', params = {}, options = {})
      request(uri(action), options.merge(method: :post, params: params))
    end

    def self.delete(action = '', params = {}, options = {})
      request(uri(action), options.merge(method: :delete, params: params))
    end

    def self.request(url, options = {})
      options = Nestful::Helpers.deep_merge(self.options, options)

      Nestful::Request.new(
        url, options
      ).execute
    end

    def uri(*parts)
      id ? self.class.uri(id, *parts) : self.class.uri(*parts)
    end
  end
end
