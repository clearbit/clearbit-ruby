require 'nestful'
require 'apihub/version'

module APIHub
  def self.api_key=(value)
    Base.options Base.options.merge(
      :auth_type => :bearer,
      :password  => value
    )
  end

  def self.key=(value)
    self.api_key = value
  end

  class Base < Nestful::Resource
    endpoint 'https://api.apihub.co'
    options :format => :json
  end

  autoload :Person, 'apihub/person'
end