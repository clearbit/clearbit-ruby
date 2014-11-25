# Clearbit

A Ruby API client to [https://clearbit.com](https://clearbit.com).

## Installation

Add this line to your application's Gemfile:

    gem 'clearbit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clearbit

## Usage

First authorize requests by setting the API key found on your [account's settings page](https://clearbit.com/profile).

    Clearbit.key = ENV['CLEARBIT_KEY']

Then you can lookup people by email address:

    person = Clearbit::Streaming::Person[email: 'info@eribium.org']

If the person can't be found, then `nil` will be returned.

See the [documentation](https://clearbit.com/docs#person-api) for more information.

## Company lookup

You can lookup company data by domain name:

    company = Clearbit::Streaming::Company[domain: 'uber.com']

If the company can't be found, then `nil` will be returned.

See the [documentation](https://clearbit.com/docs#company-api) for more information.

## CLI

The gem also includes a `clearbit` executable, which you can use like this:

    $ clearbit person --email info@eribium.org

        {
          "name": {
            "fullName": "Alex MacCaw",
            "givenName": "Alex",
            "familyName": "MacCaw"
          },
          ...

Or to look up a company:

    $ clearbit company --domain uber.com

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