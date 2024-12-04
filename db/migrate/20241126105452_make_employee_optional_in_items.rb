class MakeEmployeeOptionalInItems < ActiveRecord::Migration[7.2]
  def change
    change_column_null :items, :employee_id, true
  end
end
