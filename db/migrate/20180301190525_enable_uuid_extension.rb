class EnableUuidExtension < ActiveRecord::Migration[5.1]
  def change
    add_column :rois, :uuid, :uuid
  end
end
