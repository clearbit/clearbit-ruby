require 'clearbit'
require 'pp'

pp Clearbit::Person.find(email: 'alex@alexmaccaw.com')
