# Getting Started with Clearbit::Analytics

## Initialization

Make sure you set your `Clearbit.key` as part of your apps initialization, or before you make use of `Clearbit::Analytics`. You can find your secret key at [https://dashboard.clearbit.com/api](https://dashboard.clearbit.com/api)

`Clearbit.key = 'sk_…'`.

We also recommend ensuring that every person has a randomly generated `anonymous_id` to aid tracking page events and assist in matching up anonymous traffic to signed in users.

```ruby
class ApplicationController
  before_action :set_anonymous_id
  …

  def set_anonymous_id
    session[:anonymous_id] ||= SecureRandom.uuid
  end

  …
end
```

## Importing Users into X

You'll want to loop through your users, and call `.identify` for each one, passing the users `id`, and their `email` along with any other traits you value.

```ruby
User.find_in_batches do |users|
  users.each do |user|
    Clearbit::Analytics.identify(
      user_id: user.id, # Required.
      traits: {
        email: user.email, # Required.
        company_domain: user.domain || user.email.split('@').last,  # Optional, strongly recommended.
        first_name: user.first_name,  # Optional.
        last_name: user.last_name, # Optional.
        # … other analytical traits can also be sent, like the plan a user is on etc.
      },
    )
  end
end
```

## Identifying Users on sign up / log in

Identifying users on sign up, or on log in will help Clearbit X associate the user with anonymous page views.

```ruby
class SessionsController
  …

  def create
    …

    identify(current_user)

    …
  end

  private

  def identify(user)
    Clearbit::Analytics.identify(
      user_id: user.id, # Required
      anonymous_id: session[:anonymous_id], # Optional, strongly recommended. Helps Clearbit X associate with anonymous visits.
      traits: {
        email: user.email, # Required.
        company_domain: user.domain || user.email.split('@').last,  # Optional, strongly recommended.
        first_name: user.first_name,  # Optional.
        last_name: user.last_name, # Optional.
        # … other analytical traits can also be sent, like the plan a user is on etc.
      },
      context: {
        ip: request.ip, # Optional, but strongly recommended. Helps Clearbit X associate with anonymous visits.
      },
    )
  end

  …
end
```

## Sending Page views

Tracking page views is best done using a `anonymous_id` you generate for each user. You'll need to sent the `url` as part of the `properties` hash, and the `ip` as part of the `context` hash. Any other data you can provide will greatly help with segmentation inside of Clearbit X.


```ruby
uri = URI(request.referer) # You'll likely want to do some error handling here.

Clearbit::Analytics.page(
  user_id: current_user&.id, # Optional
  anonymous_id: session[:anonymous_id], # Required
  properties: {
    url: request.referrer, # Required. Because this is a backend integration, the referrer is the URL that was visited.
    path: format_path(uri.path), # Optional, but strongly recommended.
    search: format_search(uri.params), # Optional, but strongly recommended.
    referrer: nil, # Optional. Not the `request.referer`, but the referrer of the original page view.
  },
  context: {
    ip: request.ip, # Required. Helps Clearbit X associate anonymous visits with Companies.
  },
)

def format_path(path)
  path.presence || '/'
end

def format_search(search)
  return unless search
  '?' + search
end
```
