require 'clearbit/analytics/defaults'
require 'clearbit/analytics/utils'
require 'clearbit/analytics/field_parser'
require 'clearbit/analytics/client'
require 'clearbit/analytics/worker'
require 'clearbit/analytics/request'
require 'clearbit/analytics/response'
require 'clearbit/analytics/logging'

module Clearbit
  class Analytics
    # Proxy identify through to a client instance, in order to keep the client
    # consistent with how the other Clearbit APIs are accessed
    def self.identify(args)
      analytics = new(write_key: Clearbit.key)
      analytics.identify(args)
      analytics.flush
    end

    # Initializes a new instance of {Clearbit::Analytics::Client}, to which all
    # method calls are proxied.
    #
    # @param options includes options that are passed down to
    #   {Clearbit::Analytics::Client#initialize}
    # @option options [Boolean] :stub (false) If true, requests don't hit the
    #   server and are stubbed to be successful.
    def initialize(options = {})
      Request.stub = options[:stub] if options.has_key?(:stub)
      @client = Clearbit::Analytics::Client.new options
    end

    def method_missing(message, *args, &block)
      if @client.respond_to? message
        @client.send message, *args, &block
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      @client.respond_to?(method_name) || super
    end

    include Logging
  end
end
