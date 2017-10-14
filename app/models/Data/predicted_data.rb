require_relative './../Prediction_Models/model'
require_relative './time_series'
require_relative './../Periods/periodicity'
require 'date'

class Predicted_data < Time_series
    attr_reader :model, :first_prediction_date

    def initialize(product_id, seasonality = Time_series::NO_SEASONALITY, period, first_prediction_date, model)
        super(product_id, seasonality, period)
        @model = model
        #Primera fecha para la que se haría una predicción
        @first_prediction_date = first_prediction_date
        #Fecha en la que se hará la sigiente predicción
        @next_prediction_date = first_prediction_date
    end

    #La ultima fecha para la que se hizo una predicción
    def last_prediction_date
        #Si no hay predicciones almacenadas
        if @first_prediction_date == @next_prediction_date
            return @first_prediction_date
        else
            return @period.previous_period(@next_prediction_date)
        end
    end

    def load_records(sales)
        #Si es una coleccion de predicciones
        if sales.respond_to?("each")
            for sale in sales
                @sales.push(sale)
                @dates.push(@next_prediction_date)
                @next_prediction_date = @period.next_period(@next_prediction_date)
            end
        #Si no es una colección entonces es una sola predicción
        else
            @sales.push(sales)
            @dates.push(@next_prediction_date)
            @next_prediction_date = @period.next_period(@next_prediction_date)
        end
    end
end