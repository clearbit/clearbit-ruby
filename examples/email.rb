require 'clearbit'
require 'pp'

Clearbit.api_key = ENV['CLEARBIT_KEY_LOCAL']

pp Clearbit::Person[email: 'info@eribium.org']