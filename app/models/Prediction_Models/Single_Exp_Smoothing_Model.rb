require_relative '../Base_Prediction_Model/base_model'
require_relative './../Data/historical_data'
require_relative './../Data/predicted_data'
require 'date'

class Single_Exp_Smoothing_Model < BaseModel
    @public_name = "Suavizacion exponencial"
    @parameters_list = ["Alfa"]
    @local_parameters = [:Alpha]

    def initialize(parameters)
        super(parameters)
    end

    protected
    def run_model(sales, num_of_predictions)
        alpha = @parameters[:Alpha]
        predictions = []

        #Suavizacion exponencial, se inicializa suponiendo que F1 = D0 = sales[0]
        previous_prediction = (sales.first * 1.0)

        #Calcular y guardar F2 - Fn        
        for i in (2..sales.size)
            predictions.push(previous_prediction)
            previous_prediction = alpha * (sales[i - 1] * 1.0) + (1.0 - alpha) * previous_prediction
        end

        #Cargar num_of_predictions predicciones futuras
        num_of_predictions.times do
            predictions.push(previous_prediction)
        end
        return predictions
    end
end
