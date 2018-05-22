class AddCompanyToRois < ActiveRecord::Migration[5.1]
  def change
    add_column :rois, :company, :string
  end
end
