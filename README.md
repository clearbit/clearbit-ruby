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

You can also look people up by GitHub and Twitter handle:

    person = APIHub::Person[github: 'maccman']
    person = APIHub::Person[twitter: 'maccaw']

## CLI

The gem also includes a `apihub` executable, which you can use like this:

    $ apihub --twitter DanielZarick

        {
          "id" => "7baccc21-36a7-436c-8d55-e3d15b61dbdf",
          "name" => "Daniel Zarick",
          "headline" => "Developer at 33cc77",
          "url" => "http://danielzarick.com",
          ...
