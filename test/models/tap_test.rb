require "test_helper"

class TapTest < ActiveSupport::TestCase
  test "create a tap without a name is not allowed" do
    tap = Tap.new
    assert_not tap.save, "Saved the tap without a name"
  end

  test "create a tap without a beverage is ok" do
    tap = Tap.new(name: "Test Tap")
    assert tap.save, "Failed to save the tap without a beverage"
  end
end
