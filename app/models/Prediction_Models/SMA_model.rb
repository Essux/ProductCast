require_relative '../Base_Prediction_Model/base_model'
require_relative '../Data/historical_data'
require_relative '../Data/predicted_data'
require_relative '../Errors/parameter_error'
require 'date'

# Simple Moving Average
class SMA_model < BaseModel
  @public_name = "Promedio Móvil Simple"
  @parameters_list = ["N"]
  
  def initialize(n, model_id, name)
    parameters = { :N => n}
    super(model_id, name, parameters)
  end

  def run(historical_data, num_of_predictions)
    prediction = Predicted_data.new(historical_data.product_id,
                                    historical_data.seasonality,
                                    self, num_of_predictions)

    if historical_data.num_of_records == 0 || num_of_predictions == 0
      return prediction
    end

    if historical_data.num_of_records < parameters[:N]
      raise ParameterError, [
             "El parametro N no puede ser mayor que el periodo de datos",
             "historicos seleccionados"
           ].join(" ")
    end

    # Calculates forecast (I think that this should be a private function but
    # for now lets leave this here c: )
    sum = 0
    for d in historical_data.sales.drop(parameters[:N])
      sum += d
    end

    forecast = sum/parameters[:N]

    # Load prediction (this should be a function I guess)
    sales = []
    dates = []
    last_date = historical_data.dates[historical_data.num_of_records - 1]
    num_of_predictions.times do
      last_date = last_date.next_month
      sales.push(forecast)
      dates.push(last_date)
    end

    prediction.load_records(sales, dates)
    return prediction
  end
end
