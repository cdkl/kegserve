require "test_helper"

class BeverageTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "should not save beverage without name" do
    beverage = Beverage.new
    assert_not beverage.save, "Saved the beverage without a name"
  end

  test "should save beverage with valid name" do
    beverage = Beverage.new(name: "Coffee")
    assert beverage.save, "Failed to save the beverage with a valid name"
  end
end
