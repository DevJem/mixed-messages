class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.references :uploads, index: true, foreign_key: true
    	t.string :tag_name, null: false


      t.timestamps null: false
    end
  end
end
 