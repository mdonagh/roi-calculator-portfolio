class CreateRoi < ActiveRecord::Migration[5.0]
  def change
    create_table :rois do |t|
      t.string :name
      t.string :email
      t.string :telephone
      t.string :priority
      t.integer :product_types
      t.integer :field_technicians
      t.float :visits_per_day_per_technician
      t.integer :profit_from_additional_truck_rolls # calculated
      t.integer :eliminated_costs_from_return_visits # calculated
      t.integer :total_annual_savings # calculated
      t.integer :savings_per_service_tech # calculated
      t.float :monthly_pricing_per_service_tech # calculated
    end
  end
end
