class CreateBucketLists < ActiveRecord::Migration
  def change
    create_table :bucket_lists do |t|
      t.integer :user_id
      t.string :name

      add_index :bucket_lists, :user_id 
      
      t.timestamps null: false
    end
  end
end
