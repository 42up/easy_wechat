# EasyWechat

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/easy_wechat`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_wechat'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install easy_wechat

## Usage

```
EasyWechat.configure do |config|
  config.appid = ENV.fetch("APPID") || ""
  config.app_secret = ENV.fetch("APP_SECRET") || ""
end

client = EasyWechat::Client.new
client.token
client.batchget_material
client.uploadimg(media)
client.add_news(articles)
client.get_user_summary(begin_date, end_date)
client.get_user_cumulate(begin_date, end_date)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/easy_wechat.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
