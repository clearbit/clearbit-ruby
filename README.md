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

    APIHub.api_key = ENV['APIHUB_KEY']

Then you can lookup people by email address:

    person = APIHub::Person[email: 'info@eribium.org']

If the person can't be found, then `nil` will be returned.

See the [documentation](https://apihub.co/docs/person) for more information.

## Company lookup

You can lookup company data by domain name:

    company = APIHub::Company[domain: 'uber.com']

If the company can't be found, then `nil` will be returned.

See the [documentation](https://apihub.co/docs/company) for more information.

## CLI

The gem also includes a `apihub` executable, which you can use like this:

    $ apihub person --email info@eribium.org

        {
          "name": {
            "fullName": "Alex MacCaw",
            "givenName": "Alex",
            "familyName": "MacCaw"
          },
          ...

Or to look up a company:

    $ apihub company --domain uber.com

        {
          "name": "Uber",
          "legalName": "Uber, Inc.",
          "categories": [
            "Transport"
          ],
          "founders": [
            "Travis Kalanick",
            "Garrett Camp"
          ],
          ...