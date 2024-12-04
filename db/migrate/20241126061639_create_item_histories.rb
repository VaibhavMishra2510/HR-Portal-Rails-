class CreateItemHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :item_histories do |t|
      t.references :item, null: false, foreign_key: true  # Adds foreign key reference to item
      t.string :employee_name
      t.date :issued_date
      t.date :returned_date

      t.timestamps
    end
  end
end
