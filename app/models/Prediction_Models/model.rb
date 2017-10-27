require_relative './../Data/time_series'
require_relative './../Data/predicted_data'
require_relative './../Data/historical_data'

class Model
    attr_reader :model_id, :name
    attr_accessor :parameters

    def initialize(model_id, name, parameters)
        @model_id = model_id
        @name = name
        @parameters = parameters
    end

    
    def run(historical_data, num_of_predictions)
        if historical_data.num_of_records == 0
            raise 'No historical records found'
        end

        #Parametro de Predicted_data
        first_prediction_date = historical_data.period.next_period(historical_data.dates.last)
        prediction = Predicted_data.new(historical_data.product_id, historical_data.seasonality, historical_data.period, first_prediction_date,self)        
 
        #Si no se solicitaron predicciones
        if num_of_predictions == 0
            return prediction
        end
    
        #Obtener y cargar predicciones en 'prediction'
        predictions = run_model(historical_data.sales, num_of_predictions)
        prediction.load_records(predictions)
        return prediction
    end

    protected
    #Recibe un arreglo de ventas, retorna un arreglo de num_of_predictions ventas predichas
    def run_model(sales, num_of_predictions)
        raise 'Not implemented!'
    end

end