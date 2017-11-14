require_relative '../Base_Prediction_Model/base_model'
require_relative './../Data/historical_data'
require_relative './../Data/predicted_data'
require 'date'

class Double_Exp_Smoothing_Model < BaseModel
    @public_name = "Suavizacion exponencial con ajuste de tendencia"
    @parameters_list = ["Alfa", "Beta"]
    @local_parameters = [:Alpha, :Beta]
  
    def initialize(parameters)
        super(parameters)
    end

    protected
    def run_model(sales, num_of_predictions)
        alpha = @parameters[:Alpha]
        beta = @parameters[:Beta]
        predictions = []

        #Doble suavizacion exponencial
        #S: Demanda proyectada, T: valor proyectado de la tendencia, F: Pronostico que resulta de sumarlos
        
        #Se inicia con S1 = D0 y T1 = 0
        currS = sales.first
        currT = 0
        currF = currS + currT

        #Generar las predicciones pasadas y cargarlas
        for i in (2..sales.size)
            predictions.push(currF)
            prevS = currS
            prevT = currT

            currS = alpha * (sales[i - 1] * 1.0) + (1.0 - alpha) * (prevS + prevT)
            currT = beta * (currS - prevS) + (1.0 - beta) * prevT
            currF = currS + currT
        end

        #Cargar las num_of_predictions predicciones futuras
        num_of_predictions.times do 
            predictions.push(currF)
            currF += currT
        end
        return predictions
    end      
end
