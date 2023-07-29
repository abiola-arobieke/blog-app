require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Mary', posts_counter: 0) }

  context '#validation' do
    it 'should accept name and posts_counter and save to the database' do
      expect(subject).to be_valid
    end

    it 'should validate_presence_of(:name)' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should validate_presence_of(:posts_counter)' do
      subject.posts_counter = 0
      expect(subject).to be_valid
    end

    it 'should validate_integer_is_positive(:posts_counter)' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'expect posts_counter should be an integer' do
      subject.posts_counter = 2.5
      expect(subject).to_not be_valid
    end
  end

  context 'check if the most_recent_posts method is working' do
    it 'should return the most recent post' do
      first_user = User.create(name: 'Mary', posts_counter: 0)

      second_post = Post.create(author: first_user, title: 'My second post', text: 'second post',
                                comments_counter: 0, likes_counter: 0, created_at: 'Fri, 28 Jul 2023 09:53:46')

      third_post = Post.create(author: first_user, title: 'My third post', text: 'third post', comments_counter: 0,
                               likes_counter: 0, created_at: 'Fri, 28 Jul 2023 09:54:46')

      fourth_post = Post.create(author: first_user, title: 'My fourth', text: 'fourth post',
                                comments_counter: 0, likes_counter: 0, created_at: 'Fri, 28 Jul 2023 09:58:46')

      recent_posts = first_user.most_recent_posts

      expect(recent_posts.length).to eq(3)
      expect(recent_posts).to eq([fourth_post, third_post, second_post])
    end
  end
end
