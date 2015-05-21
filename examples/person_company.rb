require 'clearbit'
require 'pp'

pp Clearbit::PersonCompany.find(email: 'alex@alexmaccaw.com', given_name: 'Alex', family_name: 'MacCaw')
