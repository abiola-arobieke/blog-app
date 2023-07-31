require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Mary', posts_counter: 0) }
  let(:post) do
    Post.create(author: user, title: 'My recent post', text: 'Rule your world', comments_counter: 0, likes_counter: 0)
  end

  subject { Comment.create(author: user, post:, text: 'I love the post') }

  context '#validation' do
    it 'should validate_presence_of(:text)' do
      subject.text = nil
      expect(subject).to_not be_valid
    end
  end

  context 'check association between comment and user' do
    it 'should belong to the post' do
      expect(subject.post).to eq(post)
    end

    it 'should belong to the user' do
      expect(subject.author).to eq(user)
    end
  end

  context 'check if the comments counter method update the comment count' do
    it 'updates the comments_counter of the associated post after creating a comment' do
      subject

      expect(post.comments_counter).to eq(1)
    end
  end
end
