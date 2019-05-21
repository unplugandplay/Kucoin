# KuCoin REST Client in Ruby

This gem provides a REST client to interface with [KuCoin's v2 API](https://docs.kucoin.com).

The webservice client hasn't been implemented yet but will be implemented eventually (pull requests are more than welcome!)

## Getting started

First of all you'll need to get an account on KuCoin, [click here to get one](https://www.kucoin.com).

After setting up your account, head to "Account", locate the "API Management" section and click on "Create API".

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kucoin'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kucoin

## Setup

```ruby
Kucoin.configure do |config|
  config.key          =   YOUR_API_KEY
  config.secret       =   YOUR_API_SECRET
  config.passphrase   =   PASSPHRASE_YOU_USED_TO_CREATE_THE_API_KEY
end
```

## Usage

REST Client (see specs/source code for available methods/endpoints):

```ruby
client = Kucoin::Rest::Client.new
client.ticker("XRP-USDT")
```

## Status

The REST API hasn't been fully implemented yet, but nearly all endpoints are there. Transfer endpoints are still on the todo list.
Better spec coverage also needs to be implemented.
The model parsing/management will also be moved to Virtus eventually.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kucoin. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Kucoin project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/kucoin/blob/master/CODE_OF_CONDUCT.md).
