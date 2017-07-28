# Minispec::Rails

Use Minitest::Spec in Rails.

## Why another minitest rails gem?

There are plenty out there, and I'm sure they all work just fine.
I have personally never used any of them because it was never a big deal to insert Minitest::Spec into any Rails project manually with just a few lines of code.
Fewer gems/lines of code your project = better.
But I still want the convenience of a gem to get projects started quickly.

This gem gets you PURE minitest spec in a whopping 50 lines of code, and that's counting blank lines, comments, requires, and a (hopefully temporary) workaround for system tests.
There's no fancy tricks going on here.
This is plain jane minitest.
What you get is PURE spec awesomeness.
And by "PURE" I mean just `describe`s. No more defining classes on your own.

## Goals

* Get running in Rails with Minitest::Spec with minimal lines of code both in installation and the gem itself.

## NOT Goals

* **Help with migrating from "Rails style" to Spec style.** I don't recommend anyone convert any test suite to spec style for the sake of converting. You really don't gain all that much by converting.
* **Support multiple styles (i.e. unit and spec).** You're probably here to use Spec style, so use Spec style. Why would you want to mix and match? Don't define test classes. Use `describe`.
* **Support old Rails versions.** Since I don't recommend converting, it doesn't seem worth it to support older Rails versions. I'm not going to explicitly define a minimum Rails version requirement, but for development I'm going to start with 5.1.1 (see the example app).
* **(for now at least) Rails generators.** I personally don't find them all that useful. If there is enough demand for it and/or someone contributes it, I might do it, but in the interest of keeping this gem small, I'm going to skip them.

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
There is 1 exception: system tests (see below).

### Spec Types

The key to getting the right type of test is to describe the right thing.

| Test subclass                   | describe example                  |
| ------------------------------- | --------------------------------- |
| ActionDispatch::IntegrationTest | `describe MyController`           |
| ActiveJob::TestCase             | `describe MyJob`                  |
| ActionMailer::TestCase          | `describe MyMailer`               |
| ActionDispatch::SystemTestCase  | `describe 'Admin system'`         |
| ActionDispatch::IntegrationTest | `describe 'Customer integration'` |
| ActiveSupport::TestCase         | `describe 'AnythingElse'`         |

### Example app

See the [example rails app](https://github.com/ordinaryzelig/minispec-rails-example).

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

## TODO

* Ask Rails to add `run_load_hooks` for ActionDispatch::SystemTestCase so we can lazy load like the others.
* Custom file types? I like file types with extensions like `spec/models/my_model.spec.rb`.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
