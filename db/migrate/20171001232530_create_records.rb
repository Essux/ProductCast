class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.date :date
      t.integer :sales
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
