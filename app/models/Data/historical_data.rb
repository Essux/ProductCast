require_relative './time_series'

class Historical_data < Time_series
    def initialize(product_id, period, seasonality = Time_series::NO_SEASONALITY)
        super(product_id, seasonality, period)
    end

    def load_records(sales, dates)
        #Si es una coleccion de registros
        if sales.respond_to?("each") && dates.respond_to?("each")
            #Verificar que sales y dates tengan el mismo número de registros
            if sales.size == dates.size
                @sales.concat(sales)
                @dates.concat(dates)
            else
                raise "The number of dates and sales records does not match"
            end
        #Sino es una colección entonces es un solo registro
        else
            @sales.push(sales)
            @dates.push(dates)
        end
    end
end


