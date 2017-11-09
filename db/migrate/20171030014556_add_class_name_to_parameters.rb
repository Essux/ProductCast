class AddClassNameToParameters < ActiveRecord::Migration[5.1]
  def change
    add_column :parameters, :class_name, :string
  end
end
