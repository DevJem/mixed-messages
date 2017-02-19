class AddTagsToUploads < ActiveRecord::Migration
  def change
  	add_column :uploads, :tags, :string
  end
end
