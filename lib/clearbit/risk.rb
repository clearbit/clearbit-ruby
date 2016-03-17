module Clearbit
  class Risk < Base
    endpoint 'https://risk.clearbit.com'
    path '/v1'

    def self.calculate(values = {})
      self.new get('calculate', values)
    end

    def self.confirmed(values = {})
      self.new post('confirmed', values)
    end

    def self.flag(values = {})
      self.new post('flag', values)
    end
  end
end
