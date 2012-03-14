class AddIndexToUsersNameAndEmail < ActiveRecord::Migration
  def change
    add_index :users, [:name, :email], unique: true
  end
end
