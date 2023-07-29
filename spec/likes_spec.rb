require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'Hello', text: 'Test post', comments_counter: 0, likes_counter: 0) }

  subject { Like.create(author: user, post:) }

  context 'check associations between author and post' do
    it 'should belong to an author' do
      expect(subject.author).to eq(user)
    end

    it 'should belong to a post' do
      expect(subject.post).to eq(post)
    end
  end

  context 'check if the update_like_counters is woorking' do
    it 'should increase the likes counter on the post' do
      subject

      expect(post.likes_counter).to eq(1)
    end
  end
end
