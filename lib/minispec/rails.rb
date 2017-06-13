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
        desc.is_a?(Class) && desc < AbstractController::Base
      end
    end

  end
end
