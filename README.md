# RuboCop::CableReady

CableReady-specific analysis for your projects, as an extension to [RuboCop](https://github.com/rubocop/rubocop).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-cable_ready'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install rubocop-cable_ready
```

## Usage

You need to tell RuboCop to load the CableReady extension. There are threeways to do this:

### RuboCop configuration file

Put this into your `.rubocop.yml`.

```yaml
require: rubocop-cable_ready
```

Alternatively, use the following array notation when specifying multiple extensions.

```yaml
require:
  - rubocop-other-extension
  - rubocop-cable_ready
```

Now you can run `rubocop` and it will automatically load the RuboCop CableReady cops together with the standard cops.

### Command line

```bash
rubocop --require rubocop-cable_ready
```

### Rake task

```ruby
RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-cable_ready'
end
```

## Cops

#### `CableReady/ApplicationRecordEnableUpdates`

| Enabled by default | Supports autocorrection | Include | Version Added | Version Changed |
| --- | --- | --- | --- | --- |
| true | No | `app/models/**/*.rb` | 0.2.0 | 0.2.0 |

The `enable_cable_ready_updates` class method shouldn't be called in `ApplicationRecord`. Instead call `enable_cable_ready_updates` in every model you want to track and broadcast updates.


##### Examples

```ruby
# bad

class ApplicationRecord < ActiveRecord::Base
  include CableReady::Updatable

  enable_cable_ready_updates on: :update
end


# good

class Post < ApplicationRecord
  include CableReady::Updatable

  enable_cable_ready_updates on: :update
end


# good

class ApplicationRecord < ActiveRecord::Base
  include CableReady::Updatable
end

class Post < ApplicationRecord
  enable_cable_ready_updates on: :update
end
```

----

#### `CableReady/BroadcasterControllerAction`

| Enabled by default | Supports autocorrection | Include | Version Added | Version Changed |
| --- | --- | --- | --- | --- |
| false | No | `app/controllers/**/*.rb` | 0.2.0 | 0.2.0 |

It's discouraged to broadcast CableReady broadcasts from Controller actions.

##### Examples

```ruby
# bad

def create
  cable_ready[UserChannel]
    .append(selector: "...", html: "...")
    .broadcast
end


# good

def create
end
```

----

#### `CableReady/UnusedCableReadyCall`

| Enabled by default | Supports autocorrection | Include | Version Added | Version Changed |
| --- | --- | --- | --- | --- |
| true | No | `app/**/*.rb` | 0.1.0 | 0.1.0 |

The `cable_ready` method shouldn't be called without being followed by an operation.

##### Examples

```ruby
# bad

cable_ready


# good

cable_ready.inner_html(...)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcoroth/rubocop-cable_ready. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/marcoroth/rubocop-cable_ready/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RuboCop::CableReady project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/marcoroth/rubocop-cable_ready/blob/master/CODE_OF_CONDUCT.md).
