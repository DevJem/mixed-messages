class CreateNotificationsTable < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :notice, null: false
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
