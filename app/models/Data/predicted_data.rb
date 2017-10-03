require_relative './../Prediction_Models/model'
require_relative './time_series'

class Predicted_data < Time_series
    attr_reader :model
    attr_accessor :num_of_predictions

    def initialize(product_id, seasonality = Time_series::NO_SEASONALITY, model, num_of_predictions)
        super(product_id, seasonality)
        @model = model
        @num_of_predictions = num_of_predictions
    end
end