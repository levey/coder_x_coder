class AddCommentedAtColumnToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :commented_at, :timestamp
    add_index :topics, :commented_at
  end
end
