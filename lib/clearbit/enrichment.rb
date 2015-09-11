module Clearbit
  module Enrichment extend self
    autoload :Company, 'clearbit/enrichment/company'
    autoload :Person, 'clearbit/enrichment/person'
    autoload :PersonCompany, 'clearbit/enrichment/person_company'

    def find(values)
      if domain = values[:domain]
        Company.find(values)
      else
        PersonCompany.find(values)
      end
    end
  end
end