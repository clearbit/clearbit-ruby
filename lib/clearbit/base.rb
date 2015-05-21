module Clearbit
  class Base < Resource
    endpoint 'https://api.clearbit.com'
    options :format => :json

    def self.version=(value)
      options headers: {'API-Version' => value}
    end

    def self.key=(value)
      options auth_type: :bearer,
              password:  value
    end
  end
end
