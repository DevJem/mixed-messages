class FixIndexUniqueness < ActiveRecord::Migration
  def change
  	remove_index :blogs, [:user_id]
  	add_index :blogs, [:user_id, :title], unique: true

  	remove_index :comments, :user_id
  	add_index :comments, [:user_id, :title], unique: true

  	remove_index :uploads, :user_id
  	add_index :uploads, [:user_id, :title], unique: true

  	add_index :users, :id, unique: true
  end
end
