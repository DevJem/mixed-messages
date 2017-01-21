class AddTandcToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :terms_and_conditions, :integer, default: false
  end
end
