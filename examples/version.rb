require 'clearbit'
require 'pp'

Clearbit::PersonCompany.version = '2015-05-30'

Clearbit::PersonCompany.find(email: 'alex@clearbit.com', webhook_url: 'http://requestb.in/18owk611')
