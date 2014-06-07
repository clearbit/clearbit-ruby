require 'apihub'
require 'pp'

APIHub.api_key = ENV['SOURCING_KEY']

pp APIHub::Person[email: 'info@eribium.org']