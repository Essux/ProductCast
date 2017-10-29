class CreateModels < ActiveRecord::Migration[5.1]
  def change
    create_table :models do |t|
      t.string :name
      t.string :class_name

      t.timestamps
    end
  end
end
