class Forecast < ApplicationRecord
  belongs_to :execution

  def self.savePredictedData (predicted_data, execution)
    sales = predicted_data.sales
    dates = predicted_data.dates
    sales.zip(dates).each do |sales_dates|
      forecast = Forecast.new
      forecast.sales = sales_dates[0]
      forecast.date = sales_dates[1]
      forecast.execution_id = execution.id
      forecast.save
    end
  end
end
