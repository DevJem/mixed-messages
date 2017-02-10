class AddWarnLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :warn_level, :integer, default: 0
  end
end
