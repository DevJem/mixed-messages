class CreateJoinTableTagsUploads < ActiveRecord::Migration
	def change
  	create_table :tags_uploads, id: false do |t|
  		t.integer :tag_id
  		t.integer :upload_id
  	end
  end
end
