class User < ApplicationRecord
  has_many :posts, foreign_key: :author
  has_many :comments, foreign_key: :author
  has_many :likes, foreign_key: :author

  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
