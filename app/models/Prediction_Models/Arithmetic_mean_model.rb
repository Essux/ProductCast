require_relative '../Base_Prediction_Model/base_model'
require_relative '../Data/historical_data'
require_relative '../Data/predicted_data'
require 'date'

class Arithmetic_mean_model < BaseModel
    @public_name = "Media aritmética"
    
    def initialize()
        parameters = {}
        super(parameters)
    end

    protected
    def run_model(sales, num_of_predictions)
        #Hallar la media
        sum = 0
        sales.each do |sales_record|
            sum += sales_record
        end
        mean = (sum * 1.0) / (sales.size * 1.0)
        
        #Cargar y retornar el arreglo de demandas predichas
        predictions = []
        num_of_predictions.times do
            predictions.push(mean)
        end
        return predictions
    end
end