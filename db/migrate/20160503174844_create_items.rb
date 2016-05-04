class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :bucket_list_id
      t.string :name
      t.boolean :done, default: false 

      add_index :items, :bucket_list_id
      t.timestamps null: false
    end
  end
end
