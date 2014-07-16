require 'nestful'
require 'apihub/version'

module APIHub
  def self.api_key=(value)
    Base.options Base.options.merge(
      auth_type: :bearer,
      password:  value
    )
  end

  def self.key=(value)
    self.api_key = value
  end

  autoload :Base, 'apihub/base'
  autoload :Company, 'apihub/company'
  autoload :Mash, 'apihub/mash'
  autoload :Person, 'apihub/person'
  autoload :Resource, 'apihub/resource'
  autoload :Streaming, 'apihub/streaming'
end