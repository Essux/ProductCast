puts "Time_series loaded"

class Time_series
    #The seasonality value of a time series without seasonality
    NO_SEASONALITY = 1
    attr_reader :product_id, :seasonality, :sales, :dates, :num_of_records
    
    def initialize(product_id, seasonality = NO_SEASONALITY)
        @product_id = product_id
        @sales = Array.new
        @dates = Array.new
        @num_of_records = 0
        @seasonality = seasonality
    end

    
    def load_records(sales, dates)
        if sales.respond_to?("each") && dates.respond_to?("each")
            if sales.size == dates.size
                @sales.concat(sales)
                @dates.concat(dates)
                @num_of_records += sales.size
            else 
                raise "The number of dates and sales records does not match"
            end
        else 
            @sales.push(sales)
            @dates.push(dates)
            @num_of_records += 1
        end
    end
end