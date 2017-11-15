require_relative '../Base_Prediction_Model/base_model'
require_relative '../Data/historical_data'
require_relative '../Data/predicted_data'
require 'date'

require 'linear-regression'

# Linear regression model
class Linear_regression_model < BaseModel
  @public_name = "Regresión lineal"
  @ecuation = 'F = \alpha + \beta x + \epsilon'
  
  def initialize(parameters)
    super(parameters)
  end

  protected
  def run_model(sales, num_of_predictions)
    #Crear regresion(#periodo) -> ventas en ese periodo
    regression = Regression::Linear.new((1..sales.size).to_a, sales)

    #Obtener y guardar predicciones
    predictions = []
    predicted_period = 1
    while predicted_period <= sales.size + num_of_predictions do 
      predictions.push(regression.predict(predicted_period))
      predicted_period += 1
    end

    return predictions
  end
end