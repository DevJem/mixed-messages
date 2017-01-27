class AddAllowEmailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :allow_emails, :boolean
  end
end
