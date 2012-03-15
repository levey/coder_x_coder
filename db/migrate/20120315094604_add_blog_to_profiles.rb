class AddBlogToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :blog, :string
  end
end
