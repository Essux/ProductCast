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

  protected
  def run_model(sales, num_of_predictions)
    num_of_periods = @parameters[:N]
    
    #Hallar el promedio movil
    sum = 0
    i = sales.size - 1
    num_of_periods.times do
      break if i < 0
      sum += sales[i]
      i -= 1
    end
    prediction = (sum * 1.0) / (num_of_periods * 1.0)

    #Cargar y retornar el arreglo de demandas predichas
    predictions = []
    num_of_predictions.times do
      predictions.push(prediction)
    end
    return predictions
  end
end
