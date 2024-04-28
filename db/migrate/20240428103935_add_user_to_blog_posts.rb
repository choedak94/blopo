class AddUserToBlogPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :blog_posts, :user, foreign_key: true, null: true

    BlogPost.all.each do |blog_post|
      blog_post.update(user_id: User.first.id)
    end

    change_column_null :blog_posts, :user_id, false
  end
end
