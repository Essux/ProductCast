
class Time_series
    #La estacionalidad de una serie de tiempo sin estacionalidad
    NO_SEASONALITY = 1
    attr_reader :product_id, :seasonality, :sales, :dates, :period
    
    def initialize(product_id, seasonality = NO_SEASONALITY, period)
        @product_id = product_id
        @seasonality = seasonality
        @period = period
        @sales = Array.new
        @dates = Array.new
        
    end

    #Retorna el tamaño del arreglo mas pequeño entre sales y dates
    def num_of_records
        if @sales.size < @dates.size
            return @sales.size
        else 
            return @dates.size
        end
    end
end