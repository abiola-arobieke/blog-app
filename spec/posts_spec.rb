require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { User.create(name: 'David', posts_counter: 0) }

  subject do
    Post.create(author:, title: 'My first post', text: 'Here is my post.', comments_counter: 0, likes_counter: 0)
  end

  let(:first_comment) do
    Comment.create(post: subject, author:, text: 'first comment', created_at: 'Fri, 28 Jul 2023 04:51:46')
  end
  let(:second_comment) do
    Comment.create(post: subject, author:, text: 'second comment', created_at: 'Fri, 28 Jul 2023 05:51:46')
  end
  let(:third_comment) do
    Comment.create(post: subject, author:, text: 'third comment', created_at: 'Fri, 28 Jul 2023 06:51:46')
  end
  let(:fourth_comment) do
    Comment.create(post: subject, author:, text: 'fourth comment', created_at: 'Fri, 28 Jul 2023 07:51:46')
  end
  let(:fifth_comment) do
    Comment.create(post: subject, author:, text: 'fifth comment', created_at: 'Fri, 28 Jul 2023 08:51:46')
  end
  let(:sixth_comment) do
    Comment.create(post: subject, author:, text: 'sixth comment', created_at: 'Fri, 28 Jul 2023 09:51:46')
  end

  let(:first_like) { Like.create(post: subject, author:) }
  let(:second_like) { Like.create(post: subject, author:) }

  shared_examples 'a non-negative integer' do |attribute|
    it 'counter should not be negative number' do
      subject.send("#{attribute}=", -1)
      expect(subject).to_not be_valid
    end

    it 'counter should be greater than or equal to zero' do
      subject.send("#{attribute}=", 0)
      expect(subject).to be_valid

      subject.send("#{attribute}=", 1)
      expect(subject).to be_valid
    end

    it 'counter should integer' do
      subject.send("#{attribute}=", 1.5)
      expect(subject).to_not be_valid
    end
  end

  context '#validation' do
    it 'should validate_presence_of(:title)' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'should validate_length_of(:title).is_at_most(250) ' do
      subject.title = 'a' * 250
      expect(subject).to be_valid

      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'should validate_integer(:omments_counter)' do
      subject.comments_counter = 1.5
      expect(subject).to_not be_valid
    end

    it 'should validate_integer_greater_than_zero(:omments_counter)' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it_behaves_like 'a non-negative integer', :comments_counter
    it_behaves_like 'a non-negative integer', :likes_counter
  end
end
