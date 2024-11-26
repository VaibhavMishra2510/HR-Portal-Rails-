class RenameEmployeeBioAttr < ActiveRecord::Migration[7.2]
  def change
    rename_column :employees, :bio, :about
  end
end
