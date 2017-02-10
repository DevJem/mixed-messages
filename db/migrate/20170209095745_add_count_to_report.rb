class AddCountToReport < ActiveRecord::Migration
  def change
    add_column :reports, :count, :integer, default: 0
  end
end
