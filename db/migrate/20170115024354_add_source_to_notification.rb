class AddSourceToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :source, :integer
  end
end
