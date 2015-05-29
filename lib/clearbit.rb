require 'nestful'
require 'clearbit/version'

module Clearbit
  def self.api_key=(value)
    Base.key = value
  end

  def self.key=(value)
    Base.key = value
  end

  def self.key
    Base.key
  end

  def self.key!
    key || raise('Clearbit.key not set')
  end

  autoload :Base, 'clearbit/base'
  autoload :Company, 'clearbit/company'
  autoload :Mash, 'clearbit/mash'
  autoload :Person, 'clearbit/person'
  autoload :PersonCompany, 'clearbit/person_company'
  autoload :Resource, 'clearbit/resource'
  autoload :Streaming, 'clearbit/streaming'
  autoload :Watchlist, 'clearbit/watchlist'
  autoload :Webhook, 'clearbit/webhook'

  module Errors
    autoload :InvalidWebhookSignature, 'clearbit/errors/invalid_webhook_signature'
  end

  if clearbit_key = ENV['CLEARBIT_KEY']
    Clearbit.key = clearbit_key
  end
end
