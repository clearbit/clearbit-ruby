# Clearbit

A Ruby API client to [https://clearbit.com](https://clearbit.com).

## Maintenance Status

This repository is currently not actively maintained. If you're looking to integrate with Clearbit's API we recommend looking at the HTTP requests available in our documentation at [clearbit.com/docs](https://clearbit.com/docs)

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'clearbit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clearbit

## Usage

First authorize requests by setting the API key found on your [account's settings page](https://clearbit.com/keys).

``` ruby
Clearbit.key = ENV['CLEARBIT_KEY']
```

Then you can lookup people by email address:

``` ruby
result = Clearbit::Enrichment.find(email: 'alex@alexmaccaw.com', stream: true)

person  = result.person
company = result.company
```

Passing the `stream` option makes the operation blocking - it could hang for 4-5 seconds if we haven't seen the email before. Alternatively you can use our [webhook](https://clearbit.com/docs#webhooks) API.

Without the `stream` option, the operation is non-blocking, and we will immediately return either the enriched data or `Clearbit::Pending` object.

```ruby
result = Clearbit::Enrichment.find(email: 'alex@alexmaccaw.com')

if result.pending?
  # Lookup queued - try again later
end

# Later
unless result.pending?
  person  = result.person
  company = result.company
end

```

In either case, if a person or company can't be found, the result will be `nil`.

See the [documentation](https://clearbit.com/docs#person-api) for more information.
## Name to Domain

To find the domain based on the name of a resource, you can use the `NameDomain` API.

```ruby
name = Clearbit::NameDomain.find(name: 'Uber')
```
For more information look at the [documentation](https://dashboard.clearbit.com/docs?ruby#name-to-domain-api).

## Company lookup

You can lookup company data by domain name:

``` ruby
company = Clearbit::Enrichment::Company.find(domain: 'uber.com', stream: true)
```

If the company can't be found, then `nil` will be returned.

See the [documentation](https://clearbit.com/docs#company-api) for more information.

## Analytics

*NOTE:* We **strongly** recommend using `clearbit.js` for Analytics and integrating with Clearbit X. It handles a lot of complexity, like generating `anonymous_id`s and associating them with `user_id`s when a user is identified. It also automatically tracks `page` views with the full data set.

### Identifying Users

Identify users by sending their `user_id`, and adding details like their `email` and `company_domain` to create People and Companies inside of Clearbit X.

```ruby
Clearbit::Analytics.identify(
  user_id: '1234', # Required if no anonymous_id is sent. The user's ID in your database.
  anonymous_id: session[:anonymous_id], # Required if no user_id is sent. A UUID to track anonymous users.
  traits: {
    email: 'david@clearbitexample.com', # Optional, but strongly recommended
    company_domain: 'clearbit.com',     # Optional, but strongly recommended
    first_name: 'David', # Optional
    last_name: 'Lumley', # Optional
    # … other analytical traits can also be sent, like the plan a user is on etc
  },
  context: {
    ip: '89.102.33.1' # Optional, but strongly recommended when identifying users
  }                   # as they sign up, or log in
)
```

### Page Views

Use the `page` method, and send the users `anonymous_id` along with the `url` they're viewing, and the `ip` the request comes from in order to create Companies inside of Clearbit X and track their page views.

```ruby
Clearbit::Analytics.page(
  user_id: '1234', # Required if no anonymous_id is sent. The user's ID in your database.
  anonymous_id: session[:anonymous_id], # Required if no user_id is sent. A UUID to track anonymous users.
  name: 'Clearbit Ruby Library', # Optional, but strongly recommended
  properties: {
    url: 'https://github.com/clearbit/clearbit-ruby?utm_source=google', # Required. Likely to be request.referer
    path: '/clearbit/clearbit-ruby', # Optional, but strongly recommended
    search: '?utm_source=google', # Optional, but strongly recommended
    referrer: nil, # Optional. Unlikely to be request.referrer.
  },
  context: {
    ip: '89.102.33.1', # Optional, but strongly recommended.
  },
)
```

## Other APIs

For more info on our other APIs (such as the Watchlist or Discover APIs), please see our [main documentation](https://clearbit.com/docs).

## Webhooks

For rack apps use the `Clearbit::Webhook` module to wrap deserialization and verify the webhook is from trusted party:

``` ruby
post '/v1/webhooks/clearbit' do
  begin
    webhook = Clearbit::Webhook.new(request.env)
    webhook.type #=> 'person'
    webhook.body.name.given_name #=> 'Alex'

    # ...
  rescue Clearbit::Errors::InvalidWebhookSignature => e
    # ...
  end
end
```

The global Clearbit.key can be overriden for multi-tenant apps using multiple Clearbit keys like so:

```ruby
webhook = Clearbit::Webhook.new(request.env, 'CLEARBIT_KEY')
```

## Proxy Support

Passing the proxy option allows you to specify a proxy server to pass the request through.

``` ruby
company = Clearbit::Enrichment::Company.find(
  domain: 'uber.com',
  proxy: 'https://user:password@proxyserver.tld:8080'
)
```
