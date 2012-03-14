class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :realname
      t.string :location
      t.string :company
      t.string :github
      t.string :twitter
      t.string :weibo
      t.text :bio

      t.timestamps
    end
  end
end
