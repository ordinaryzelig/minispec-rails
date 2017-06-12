require "test_helper"

class Minispec::RailsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Minispec::Rails::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
