class CreateTempProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_products do |t|
      t.string :name
      t.string :category
      t.integer :quantity

      t.timestamps

      t.integer :user_id
    end
  end
end
