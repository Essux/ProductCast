class CreateAppliedParameters < ActiveRecord::Migration[5.1]
  def change
    create_table :applied_parameters do |t|
      t.references :parameter, foreign_key: true
      t.float :value
      t.references :execution, foreign_key: true

      t.timestamps
    end
  end
end
