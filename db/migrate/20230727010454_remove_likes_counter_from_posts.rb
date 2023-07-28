class RemoveLikesCounterFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :likes_counter, :string
  end
end
