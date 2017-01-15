class AddTypeToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :notice_type, :string
  end
end
