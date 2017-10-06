module Clearbit
  class NameDomain < Base
    endpoint 'https://company.clearbit.com'
    path '/v1/domains'

    def self.find(values)
      Mash.new get(uri(:find), values)
    rescue Nestful::ResourceNotFound
    end

    class << self
      alias_method :[], :find
    end
  end
end

