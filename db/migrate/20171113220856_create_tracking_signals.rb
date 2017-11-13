class CreateTrackingSignals < ActiveRecord::Migration[5.1]
  def change
    create_table :tracking_signals do |t|
      t.datetime :date
      t.float :signal
      t.references :execution, foreign_key: true

      t.timestamps
    end
  end
end
