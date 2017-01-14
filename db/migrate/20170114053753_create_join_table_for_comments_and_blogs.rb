class CreateJoinTableForCommentsAndBlogs < ActiveRecord::Migration
  def change
  	create_table :blogs_comments, id: false do |t|
  		t.integer :comment_id
  		t.integer :blog_id
  	end
  end
end
