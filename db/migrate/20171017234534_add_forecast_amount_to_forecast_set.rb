class AddForecastAmountToForecastSet < ActiveRecord::Migration[5.1]
  def change
    add_column :forecast_sets, :forecast_amount, :int
  end
end
