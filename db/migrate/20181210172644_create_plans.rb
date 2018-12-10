class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :title
      t.date :since_date
      t.date :to_date
      t.float :goal
      t.integer :user_id

      t.timestamps
    end
  end
end
