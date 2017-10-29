require 'test_helper'

class ForecastSetsControllerTest < ActionDispatch::IntegrationTest
  test "should get select_models" do
    get forecast_sets_select_models_url
    assert_response :success
  end

  test "should get select_params" do
    get forecast_sets_select_params_url
    assert_response :success
  end

end
