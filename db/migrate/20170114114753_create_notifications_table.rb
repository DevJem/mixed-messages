class CreateNotificationsTable < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :notice, null: false
      t.boolean :active, default: true
      t.string :notice_type
      t.integer :source
      t.string :source_location
      t.integer :source_id

      t.timestamps null: false
    end
  end
end
