class PostSerializer < ActiveModel::Serializer
  attributes :author, :title, :text, :comments_counter, :likes_counter
  has_many :comments
  has_many :likes

  def author
    object.author.name
  end
end
