class Like < ApplicationRecord
  has_many :author, class_name: 'User', foreign_key: 'author_id'
  has_many :post

  after_save :update_like_counter

  def update_like_count
    author.increment!(:likes_counter)
  end
end
