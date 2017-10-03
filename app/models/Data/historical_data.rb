require_relative './time_series'

class Historical_data < Time_series
    def initialize(product_id, seasonality = Time_series::NO_SEASONALITY)
        super(product_id, seasonality)
    end
end