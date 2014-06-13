require 'apihub'
require 'pp'

APIHub.api_key = ENV['APIHUB_KEY']

pp APIHub::Person[email: 'info@eribium.org']