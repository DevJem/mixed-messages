class AddSourceLocationToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :source_location, :string
    add_column :notifications, :source_id, :integer
  end
end
