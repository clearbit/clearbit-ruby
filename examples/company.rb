require 'clearbit'
require 'pp'

pp Clearbit::Company.find(domain: 'stripe.com')
