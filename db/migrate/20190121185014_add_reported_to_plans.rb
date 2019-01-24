class AddReportedToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :reported, :boolean
  end
end
