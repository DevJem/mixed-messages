class AddUploadIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :upload, index: true, foreign_key: true
  end 
end
