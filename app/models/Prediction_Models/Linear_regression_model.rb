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

  protected
  def run_model(sales, num_of_predictions)
    #Crear regresion(#periodo) -> ventas en ese periodo
    regression = Regression::Linear.new((1..sales.size).to_a, sales)

    predictions = []
    predicted_period = sales.size + 1
    num_of_predictions.times do
      predictions.push(regression.predict(predicted_period))
      predicted_period += 1
    end
    
    return predictions
  end
end