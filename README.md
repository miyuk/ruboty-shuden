# Ruboty::Shuden

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ruboty/shuden`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-shuden'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-shuden

## Usage

1. First save your route
```ruby
{botname} save route {origin_station} {dest_station}
```
2. check your route
```ruby
{botname} show route
```
3. search your last train
```ruby
{botname} shuden
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruboty-shuden.
