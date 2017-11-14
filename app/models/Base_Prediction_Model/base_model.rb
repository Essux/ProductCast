require_relative '../Data/time_series'
require_relative '../Data/predicted_data'
require_relative '../Data/historical_data'

class BaseModel
    attr_reader :model_id, :name
    attr_accessor :parameters

    @public_name = "Modelo base"
    @parameters_list = []
    @local_id = -1
    @local_parameters = []

    class << self
        attr_reader :public_name, :parameters_list, :local_parameters
        attr_accessor :local_id
    end

    def initialize(parameters)
        @local_parameters = @local_parameters.to_a
        @model_id = @local_id
        @name = @public_name
        @parameters = parameters
    end


    def run(historical_data, num_of_predictions)
        if historical_data.num_of_records == 0
            raise 'No historical records found'
        end

        #Parametro de Predicted_data
        first_prediction_date = historical_data.period.next_period(historical_data.dates.last)
        prediction = Predicted_data.new(historical_data.product_id, historical_data.seasonality,
             historical_data.period, first_prediction_date,self)

        #Si no se solicitaron predicciones
        if num_of_predictions == 0
            return prediction
        end

        #Obtiene todas las predicciones que el modelo pueda generar para periodos pasados
        #y num_of_predictions predicciones de periodos futuros
        predictions = run_model(historical_data.sales, num_of_predictions)

        #Guardar predicciones de periodos futuros
        prediction.load_records(predictions.last(num_of_predictions))

        #Eliminar los periodos futuros ya almacenados
        predictions.pop(num_of_predictions)

        #Obtener la señal de rastreo para los periodos pasados (Los unicos que tienen)
        tracking_signal = get_tracking_signal(historical_data.dates, historical_data.sales , predictions)

        #Retornar el Predicted_data y su señal de rastreo
        return [prediction, tracking_signal]
    end

    protected
    # Recibe un arreglo de registros de ventas de diferentes periodos y las predicciones generadas
    # para n de esos periodos. Genera retorna la señal de rastreo para esos n periodos en una matriz [ fechas] [valores] ]
    def get_tracking_signal(dates, sales, forecast)
        tsignal_dates = []
        tsignal = []

        #Obtener la señal de rastreo para los ultimos (forecast.size) elementos
        i = 0
        first_forecast_sale = sales.size - forecast.size
        error_sum = 0.0
        abs_error_sum = 0.0

        forecast.size.times do 
            error_sum += (sales[i + first_forecast_sale] * 1.0 - forecast[i] * 1.0)
            abs_error_sum += (sales[i + first_forecast_sale] * 1.0 - forecast[i] * 1.0).abs
            ts = error_sum / (abs_error_sum / (i + 1))

            tsignal_dates.push(dates[i + first_forecast_sale])
            tsignal.push(ts.round(2))
            i += 1
        end
        #Retornar la señal de rastreo: el arreglo de fechas y sus señales de rastreo
        tracking_signal = {:dates => tsignal_dates, :signals => tsignal}
        return tracking_signal
    end

    # Recibe un arreglo de ventas, retorna un arreglo con predicciones para cada periodo
    # de sales(siempre que el modelo lo permita) y num_of_predictions predicciones de periodos futuros
    def run_model(sales, num_of_predictions)
        raise 'Not implemented!'
    end

end