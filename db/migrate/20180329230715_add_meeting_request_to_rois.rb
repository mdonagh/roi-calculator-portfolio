class AddMeetingRequestToRois < ActiveRecord::Migration[5.1]
  def change
    add_column :rois, :meeting_requested, :boolean, default: false
  end
end
