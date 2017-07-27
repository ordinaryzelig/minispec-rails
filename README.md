# Minispec::Rails

Use Minitest::Spec in Rails.

## Why another minitest rails gem?

There are plenty out there, and I'm sure they all work just fine.
I have personally never used any of them because it was never a big deal to insert Minitest::Spec into any Rails project manually with just a few lines of code.
The fewer gems/lines of code there are, the better.
But obviously that's not very helpful to anyone who just wants it to work with a simple `gem blah`, done (including me).

## Goals

* Get running in Rails with Minitest::Spec with minimal lines of code both in installation and the gem itself.

## Not Goals

* Help with migrating from "Rails style" to Spec style. I don't recommend anyone convert any test suite to spec style for the sake of converting. You really don't gain all that much.
* Support multiple styles. You're probably here to use Spec style, so use Spec style. Why would you want to mix and match?
* Support old Rails versions. Since I don't recommend converting, I don't see a big use case for supporting older Rails versions.
* (for now at least) Rails generators. I personally don't find them all that useful. If there is enough demand for it and/or someone contributes it, I might do it, but in the interest of keeping this gem small, I'm going to skip them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minispec-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minispec-rails

## Usage

Once this gem is required, you can immediately start using it to `describe` your tests.
There is 1 exception: system tests.

### System tests

In order to lazy-load, just require the workaround before defining `ApplicationSystemTestCase`:

```ruby
# test/application_system_test_case.rb.
require "test_helper"
### 
require 'minispec/rails/system_test' # <- Add this line here.

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
```

### Spec Types

* `describe` any AbstractController::Base subclass, the test will be a subclass of ActionDispatch::IntegrationTest.
* `describe` any ActiveJob::Base subclass, the test will be a subclass of ActiveJob::TestCase.
* `describe` any ActionMailer::Base subclass, the test will be a subclass of ActiveJob::TestCase.
* `describe` any String, the test will be a subclass of ActionDispatch::SystemTestCase.
* `describe` anything else, the test will be a subclass of ActiveSupport::TestCase.

### Example app

See the [example rails app](https://github.com/ordinaryzelig/minispec-rails-example).

## TODO

* Ask Rails to add `run_load_hooks` for ActionDispatch::SystemTestCase so we can lazy load like the others.
* Custom file types? I like file types with extensions like `spec/models/my_model.spec.rb`.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
