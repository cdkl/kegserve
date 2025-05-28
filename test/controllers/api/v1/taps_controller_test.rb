require "test_helper"

module Api
  module V1
    class TapsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @tap = taps(:one)
        @beverage = beverages(:one)
      end

      test "should get index" do
        get api_v1_taps_url, as: :json
        assert_response :success

        json_response = JSON.parse(response.body)
        assert_kind_of Array, json_response
        assert_equal Tap.count, json_response.length
      end

      test "should get index with beverages" do
        @tap.update(beverage: @beverage)
        get api_v1_taps_url, as: :json

        json_response = JSON.parse(response.body)
        tap_response = json_response.find { |t| t["id"] == @tap.id }

        assert_not_nil tap_response["beverage"]
        assert_equal @beverage.id, tap_response["beverage"]["id"]
        assert_equal @beverage.name, tap_response["beverage"]["name"]
      end

      test "should show tap" do
        get api_v1_tap_url(@tap), as: :json
        assert_response :success

        json_response = JSON.parse(response.body)
        assert_equal @tap.id, json_response["id"]
        assert_equal @tap.name, json_response["name"]
      end

      test "should show tap with beverage" do
        @tap.update(beverage: @beverage)
        get api_v1_tap_url(@tap), as: :json

        json_response = JSON.parse(response.body)
        assert_not_nil json_response["beverage"]
        assert_equal @beverage.id, json_response["beverage"]["id"]
        assert_equal @beverage.name, json_response["beverage"]["name"]
      end

      test "should return not found for non-existent tap" do
        get api_v1_tap_url(id: 999999), as: :json
        assert_response :not_found

        json_response = JSON.parse(response.body)
        assert_equal "Tap not found", json_response["error"]
      end
    end
  end
end
