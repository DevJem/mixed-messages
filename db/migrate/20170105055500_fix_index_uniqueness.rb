class FixIndexUniqueness < ActiveRecord::Migration
  def up
  	remove_index :blogs, [:user_id]
  	add_index :blogs, [:user_id, :title], unique: true

  	remove_index :comments, :user_id
  	add_index :comments, [:user_id, :title], unique: true

  	remove_index :uploads, :user_id
  	add_index :uploads, [:user_id, :title], unique: true

  	add_index :users, :id, unique: true
  end

  def down
  	remove_index :users, :id

  	remove_index :uploads, [:user_id, :title]
  	add_index :uploads, :user_id

  	remove_index :comments, [:user_id, :title]
  	add_index :comments, :user_id

  	remove_index :blogs, [:user_id, :title]
  	add_index :blogs, :user_id
  end

end
