class AddEmployeeToItems < ActiveRecord::Migration[7.2]
  def change
    add_reference :items, :employee, null: false, foreign_key: true
  end
end
