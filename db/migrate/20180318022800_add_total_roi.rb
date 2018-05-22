class AddTotalRoi < ActiveRecord::Migration[5.1]
  def change
    add_column :rois, :total_roi, :integer
    add_column :rois, :payback_achieved, :integer
  end
end
