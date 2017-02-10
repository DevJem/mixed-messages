class AddBlogIdToReport < ActiveRecord::Migration
  def change
    add_column :reports, :blog_id, :integer
  end
end
