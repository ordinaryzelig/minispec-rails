require "minispec/rails/version"
require 'minitest/spec'

module Minispec
  module Rails

    # Default test will be subclass of ActiveSupport::TestCase.
    Minitest::Spec::TYPES.clear
    Minitest::Spec.register_spec_type(//, ActiveSupport::TestCase)

    # We can't force ActiveSupport to be a subclass of Minitest::Spec.
    # Next best thing.
    ActiveSupport::TestCase.extend Minitest::Spec::DSL

    ActiveSupport.on_load(:action_dispatch_integration_test) do
      Minitest::Spec.register_spec_type(ActionDispatch::IntegrationTest) do |desc|
        (desc.is_a?(Class) && desc < AbstractController::Base) ||
          (desc.to_s =~ /integration$/i)
      end
    end

    ActiveSupport.on_load(:active_job) do
      Minitest::Spec.register_spec_type(ActiveJob::TestCase) do |desc|
        desc.is_a?(Class) && desc < ActiveJob::Base
      end
    end

    ActiveSupport.on_load(:action_mailer_test_case) do
      Minitest::Spec.register_spec_type(ActionMailer::TestCase) do |desc|
        desc.is_a?(Class) && desc < ActionMailer::Base
      end
    end

  end
end
