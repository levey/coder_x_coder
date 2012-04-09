class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :notifiable_id
      t.string :notifiable_type
      t.text :content
      t.boolean :read, :default => false

      t.timestamps
    end
    add_index :notifications, [:receiver_id, :read]
  end
end
