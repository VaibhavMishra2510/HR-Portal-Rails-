class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.integer :sr_no
      t.string :name
      t.decimal :price
      t.string :issued_to
      t.date :issued_date
      t.date :returned_date

      t.timestamps
    end
  end
end
