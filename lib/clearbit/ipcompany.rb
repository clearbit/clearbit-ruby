module Clearbit
  class IPCompany < Base
    endpoint 'https://ipcompany.clearbit.com'
    path '/v1/companies'

    def self.find(values)
      if ip = values.delete(:ip)
        response = get(uri(:ip, ip), values)

      else
        raise ArgumentError, 'Invalid values'
      end

      self.new(response)
    rescue Nestful::ResourceNotFound
    end

    class << self
      alias_method :[], :find
    end
  end
end
