class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
    	t.string :title
    	t.string :content
    	t.string :email
    	t.string :user

      t.timestamps null: false
    end
  end
end
