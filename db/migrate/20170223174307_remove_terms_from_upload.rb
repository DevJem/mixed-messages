class RemoveTermsFromUpload < ActiveRecord::Migration
  def change
    remove_column :uploads, :terms_and_conditions, :integer
  end
end
