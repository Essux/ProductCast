require_relative './model'
require_relative './../Data/historical_data'
require_relative './../Data/predicted_data'
require 'date'

class Arithmetic_mean_model < Model
    def initialize(model_id, name)
        parameters = Hash.new
        super(model_id, name, parameters)
    end

    #By now, it assumes a period of one month
    def run(historical_data, num_of_predictions)
        prediction = Predicted_data.new(historical_data.product_id, historical_data.seasonality, self, num_of_predictions)
        #If there is nothing to be done
        if historical_data.num_of_records == 0 || num_of_predictions == 0
            return prediction
        end

        #find the mean
        sum = 0
        historical_data.sales.each do |sales_record|
            sum += sales_record
        end
        mean = (sum * 1.0) / (historical_data.num_of_records * 1.0)

        #load prediction
        sales = []
        dates = []
        last_date = historical_data.dates[historical_data.num_of_records - 1]
        num_of_predictions.times do
            last_date = last_date.next_month
            sales.push(mean)
            dates.push(last_date)
        end

        prediction.load_records(sales, dates)
        return prediction
    end
end