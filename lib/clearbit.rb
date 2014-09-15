require 'nestful'
require 'clearbit/version'

module Clearbit
  def self.api_key=(value)
    Base.options Base.options.merge(
      auth_type: :bearer,
      password:  value
    )
  end

  def self.key=(value)
    self.api_key = value
  end

  autoload :Base, 'clearbit/base'
  autoload :Company, 'clearbit/company'
  autoload :Mash, 'clearbit/mash'
  autoload :Person, 'clearbit/person'
  autoload :PersonCompany, 'clearbit/person_company'
  autoload :Resource, 'clearbit/resource'
  autoload :Streaming, 'clearbit/streaming'
  autoload :Watchlist, 'clearbit/watchlist'
end