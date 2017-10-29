class CreateForecasts < ActiveRecord::Migration[5.1]
  def change
    create_table :forecasts do |t|
      t.datetime :date
      t.integer :sales
      t.references :execution, foreign_key: true

      t.timestamps
    end
  end
end
