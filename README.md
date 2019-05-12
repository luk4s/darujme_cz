# DarujmeCz
[![Build Status](https://travis-ci.org/luk4s/darujme_cz.svg?branch=master)](https://travis-ci.org/luk4s/darujme_cz)
[![Maintainability](https://api.codeclimate.com/v1/badges/568759e4ec0a2e1960b2/maintainability)](https://codeclimate.com/github/luk4s/darujme_cz/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/568759e4ec0a2e1960b2/test_coverage)](https://codeclimate.com/github/luk4s/darujme_cz/test_coverage)

Darujme API https://www.darujme.cz/doc/api/v1/index.html.

This is a ruby library for access Darujme API. Get pledges for your organization, check transactions or donors.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'darujme_cz'
```
## Configuration

Firstly you need obtain `apiId` and `apiSecret` for your organization.

Then configure gem with `orgnazionation_id`, `api_id` and `api_secret`.

In your application create `config/initializers/darujme_cz.rb`

```ruby
DarujmeCz.configure do |config|
  config.organization_id = 434
  config.app_id = "1234"
  config.app_secret = "6b6fd1568d89c"
end
```

## Usage

```ruby
pledges = DarujmeCz::Pledge.where fromOutgoingDate: Date.yesterday
donor = pledges[0].donor # => DarujmeCz::Donor
donor.name # => "Jan Novák"
last_transaction = pledges[0].transactions.last # => DarujmeCz::Transaction
last_transaction.received_at # => 2019-05-06 00:00:00 +0200
last_transaction.outgoing_amount # => #<Money fractional:39200 currency:CZK>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/darujme_cz. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

GNU General Public License v3.0

See [COPYING](./COPYING) to see the full text.

## Code of Conduct

Everyone interacting in the DarujmeCz project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/darujme_cz/blob/master/CODE_OF_CONDUCT.md).
