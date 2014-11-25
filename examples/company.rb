require 'clearbit'
require 'pp'

pp Clearbit::Company[domain: 'stripe.com']