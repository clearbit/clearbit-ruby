module Clearbit
  module Enrichment extend self
    autoload :Company, 'clearbit/enrichment/company'
    autoload :Person, 'clearbit/enrichment/person'
    autoload :PersonCompany, 'clearbit/enrichment/person_company'

    def find(*args)
      PersonCompany.find(*args)
    end
  end
end
