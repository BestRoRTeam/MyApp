class CreateTipOfTheDays < ActiveRecord::Migration[5.2]
  def change
    create_table :tip_of_the_days do |t|
      t.text :text

      t.timestamps
    end
  end
end
