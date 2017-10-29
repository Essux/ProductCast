class CreateExecutions < ActiveRecord::Migration[5.1]
  def change
    create_table :executions do |t|
      t.references :forecast_set, foreign_key: true
      t.references :model, foreign_key: true

      t.timestamps
    end
  end
end
