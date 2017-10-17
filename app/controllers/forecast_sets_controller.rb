class ForecastSetsController < ApplicationController
  def select_models
    @forecast_set = ForecastSet.new
  end

  def select_params
    @forecast_set = ForecastSet.new(forecast_set_params)
  end

private

    def forecast_set_params
      params.require(:forecast_set).permit(:product_id, :model_ids => [])
    end
end
