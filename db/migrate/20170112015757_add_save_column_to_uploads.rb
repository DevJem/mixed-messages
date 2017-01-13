class AddSaveColumnToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :save_upload, :boolean, default: false
  end
end
