class CreateUsersLikedPosts < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :posts, table_name: :users_liked_posts
  end
end
