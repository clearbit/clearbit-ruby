# APIHub

A Ruby API client to [https://apihub.co](https://apihub.co).

## Installation

Add this line to your application's Gemfile:

    gem 'apihub'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apihub

## Usage

First authorize requests by setting the API key found on your [account's settings page](https://apihub.co/profile).

    APIHub.api_key = ENV['SOURCING_KEY']

Then you can lookup people by email address:

    person = APIHub::Person[email: 'info@eribium.org']

If the person can't be found, then `nil` will be returned.

## Company lookup

You can lookup company data by domain name:

    company = APIHub::Company[domain: 'uber.com']

If the company can't be found, then `nil` will be returned.

## CLI

The gem also includes a `apihub` executable, which you can use like this:

    $ apihub --email info@eribium.org

        {
          "name": {
            "fullName": "Alex MacCaw",
            "givenName": "Alex",
            "familyName": "MacCaw"
          },
          ...
