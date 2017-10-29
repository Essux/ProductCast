class CreateParameters < ActiveRecord::Migration[5.1]
  def change
    create_table :parameters do |t|
      t.references :model, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
