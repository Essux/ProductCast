require_relative '../Base_Prediction_Model/base_model'
require_relative '../Data/historical_data'
require_relative '../Data/predicted_data'
require 'date'

class Arithmetic_mean_model < BaseModel
    @public_name = "Media aritmética"
    @ecuation = 'F_{t} = \frac{\sum D_{i}}{t}'
    
    def initialize(parameters)
        super(parameters)
    end

    protected
    def run_model(sales, num_of_predictions)
        predictions = []
        sum = sales[0] * 1.0

        #Hallar la suma total
        for i in 1..sales.size-1
            #Cargar predicciones de periodos pasados
            partial_mean = sum / (i)
            predictions.push(partial_mean)
            sum += (sales[i] * 1.0)
        end

        mean = (sum * 1.0) / (sales.size * 1.0)
        #Cargar predicciones futuras y retornar el arreglo predicciones
        num_of_predictions.times do
            predictions.push(mean)
        end
        return predictions
    end
end