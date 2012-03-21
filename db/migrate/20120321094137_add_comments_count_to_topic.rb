class AddCommentsCountToTopic < ActiveRecord::Migration
  def self.up    
    add_column :topics, :comments_count, :integer, :default => 0
    
    Topic.reset_column_information 
    Topic.find_each do |topic|
      topic.update_attribute(:comments_count, topic.comments.size)
    end
  end
  
  def self.down
    remove_column :topics, :comments_count
  end
  
end
