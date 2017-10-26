require_relative './model'
require_relative './../Data/historical_data'
require_relative './../Data/predicted_data'
require 'date'

class Single_Exp_Smoothing_Model < Model
    def initialize(model_id, name, alpha)
        parameters = { :Alpha => alpha}
        super(model_id, name, parameters)
    end

    protected
    def run_model(sales, num_of_predictions)
        alpha = @parameters[:Alpha]

        #Suavizacion exponencial, se inicializa suponiendo que F1 = D0 = sales[0]
        previous_prediction= (sales.first * 1.0)
        for i in (2..sales.size)
            previous_prediction = alpha * (sales[i - 1] * 1.0) + (1.0 - alpha) * previous_prediction
        end

        #Cargar predicciones
        predictions = []
        num_of_predictions.times do
            predictions.push(previous_prediction)
        end
        return predictions
    end
end
