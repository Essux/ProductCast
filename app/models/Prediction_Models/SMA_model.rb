require_relative '../Base_Prediction_Model/base_model'
require_relative '../Data/historical_data'
require_relative '../Data/predicted_data'
require_relative '../Errors/parameter_error'
require 'date'

# Simple Moving Average
class SMA_model < BaseModel
  @public_name = "Promedio Móvil Simple"
  @parameters_list = ["N"]
  @local_parameters = [:N]
  
  def initialize(parameters)
    super(parameters)
  end

  protected
  def run_model(sales, num_of_predictions)
    num_of_periods = @parameters[:N].to_i
    predictions = []
    #Si no hay suficiente informacion para predecir
    if sales.size < num_of_periods
      return predictions
    end

    sum = 0.0
    #Sumar los primeros num_of_periods periodos, para los que no habra prediccion
    for i in 0..num_of_periods-1
      sum += sales[i] * 1.0
    end

    for i in num_of_periods..sales.size-1
      #Cargar prediccion para el periodo i
      partial_sma = sum / (num_of_periods * 1.0)
      predictions.push(partial_sma)
      
      sum -= sales[i - num_of_periods] * 1.0
      sum += sales[i] * 1.0
    end

    #Cargar predicciones de periodos futuros
    future_sma = sum / (num_of_periods * 1.0)
    num_of_predictions.times do
      predictions.push(future_sma)
    end
    
    return predictions
  end
end
