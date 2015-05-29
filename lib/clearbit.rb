require 'nestful'
require 'clearbit/version'

module Clearbit
  def self.api_key=(value)
    Base.key = value
  end

  def self.key=(value)
    Base.key = value
  end

  autoload :Base, 'clearbit/base'
  autoload :Company, 'clearbit/company'
  autoload :Mash, 'clearbit/mash'
  autoload :Person, 'clearbit/person'
  autoload :PersonCompany, 'clearbit/person_company'
  autoload :Resource, 'clearbit/resource'
  autoload :Streaming, 'clearbit/streaming'
  autoload :Watchlist, 'clearbit/watchlist'
  autoload :WebhookResponse, 'clearbit/webhook_response'
  autoload :WebhookSignature, 'clearbit/webhook_signature'

  module Errors
    autoload :InvalidWebhookSignature, 'clearbit/errors/invalid_webhook_signature'
  end

  if clearbit_key = ENV['CLEARBIT_KEY']
    Clearbit.key = clearbit_key
  end
end
