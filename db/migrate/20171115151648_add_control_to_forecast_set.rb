class AddControlToForecastSet < ActiveRecord::Migration[5.1]
  def change
    add_column :forecast_sets, :control, :int
  end
end
