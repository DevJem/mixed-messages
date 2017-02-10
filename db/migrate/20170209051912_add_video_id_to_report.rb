class AddVideoIdToReport < ActiveRecord::Migration
  def change
    add_column :reports, :video_id, :string
  end
end
