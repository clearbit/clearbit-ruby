require 'clearbit'
require 'pp'

pp Clearbit::PersonCompany.find(email: 'alex@alexmaccaw.com')
