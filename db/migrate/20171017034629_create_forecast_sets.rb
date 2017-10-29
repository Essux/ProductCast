class CreateForecastSets < ActiveRecord::Migration[5.1]
  def change
    create_table :forecast_sets do |t|
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
