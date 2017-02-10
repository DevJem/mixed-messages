class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :comment_id
      t.integer :upload_id
      
      t.timestamps null: false
    end
  end
end
