class AddThumbToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :thumb, :string
  end
end
