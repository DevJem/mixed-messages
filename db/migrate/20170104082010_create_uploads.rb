class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :zipcode
      t.string :title
      t.text :note

      t.timestamps null: false
    end
  end
end
