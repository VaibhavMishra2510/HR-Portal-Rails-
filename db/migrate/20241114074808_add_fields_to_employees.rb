class AddFieldsToEmployees < ActiveRecord::Migration[7.2]
  def change
    add_column :employees, :date_of_joining, :date
    add_column :employees, :bio, :text
  end
end
