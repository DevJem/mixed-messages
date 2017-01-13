class CreateJoinTableForCommentsAndUploads < ActiveRecord::Migration
  def change
  	create_table :comments_uploads, id: false do |t|
  		t.integer :comment_id
  		t.integer :upload_id
  	end
  end
end
