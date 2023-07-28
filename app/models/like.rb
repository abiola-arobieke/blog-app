class Like < ApplicationRecord
  has_many :author, class_name: 'User', foreign_key: 'author_id'
  has_many :post

  def update_likes_count
    post.update(likes_counter: post.likes.count)
  end
end
