class AddColumnsToEmployees < ActiveRecord::Migration[7.2]
  def change
    add_column :employees, :date_of_birth, :date
    add_column :employees, :job_title, :string
  end
end
