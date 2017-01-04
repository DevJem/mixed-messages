class AddUploadIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :uploads, index: true, foreign_key: true
  end 
end
