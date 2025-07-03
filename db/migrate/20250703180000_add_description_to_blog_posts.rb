class AddDescriptionToBlogPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :blog_posts, :description, :text
  end
end
