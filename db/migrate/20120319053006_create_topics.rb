class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.integer :hits

      t.timestamps
    end
    add_index :topics, [:user_id, :created_at]
  end
end
