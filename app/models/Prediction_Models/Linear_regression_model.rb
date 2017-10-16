require_relative '../Base_Prediction_Model/base_model'
require_relative '../Data/historical_data'
require_relative '../Data/predicted_data'
require 'date'
require 'linear-regression'

# Linear regression model
class Linear_regression_model < BaseModel
  @public_name = "Regresión lineal"
  
  def initialize(model_id, name)
    parameters = {}
    super(model_id, name, parameters)
  end

  def run(historical_data, num_of_predictions)
    prediction = Predicted_data.new(historical_data.product_id,
                                    historical_data.seasonality,
                                    self, num_of_predictions)

    if historical_data.num_of_records == 0 || num_of_predictions == 0
      return prediction
    end

    regression = Linear((1..historical_data.num_of_records).to_a,
                        historical_data.sales)

    sales = []
    dates = []
    last_date = historical_data.dates[historical_data.num_of_records - 1]
    num_of_predictions.times do |i|
      last_date = last_date.next_month
      sales.push(regression.predict(historical_data.num_of_records + i + 1))
      dates.push(last_date)
    end

    prediction.load_records(sales, dates)
    return prediction
  end
end
