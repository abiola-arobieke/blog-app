require 'rails_helper'
RSpec.feature 'Post show page', type: :feature do
  before do
    @first_user = User.create(name: 'Sameed Mohsin', bio: 'The first post from frank',
                              photo: 'https://avatars.githubusercontent.com/u/114492335?v=4',
                              posts_counter: 2)
    @second_user = User.create(name: 'Barber John', bio: 'Barber is a football player',
                               photo: 'https://avatars.githubusercontent.com/u/114492335?v=4',
                               posts_counter: 1)
    @third_user = User.create(name: 'Akeem Fauzi', bio: 'He is a rails developer',
                              photo: 'https://avatars.githubusercontent.com/u/114492335?v=4',
                              posts_counter: 4)

    @first_post = Post.create(author: @first_user, title: 'The first post',
                              text: 'Content for the first post', comments_counter: 0,
                              likes_counter: 0)

    @first_comment = Comment.create(author_id: @first_user.id, post_id: @first_post.id,
                                    text: 'This the first comment for first post')
    @second_comment = Comment.create(author_id: @second_user.id, post_id: @first_post.id,
                                     text: 'This the second comment for first post')
    @third_comment = Comment.create(author_id: @third_user.id, post_id: @first_post.id,
                                    text: 'This the third comment for first post')
    @fourth_comment = Comment.create(author_id: @first_user.id, post_id: @first_post.id,
                                     text: 'This the fourth comment for first post')
    @fifth_comment = Comment.create(author_id: @first_user.id, post_id: @first_post.id,
                                    text: 'This the fifth comment for first post')
    @six_comment = Comment.create(author_id: @first_user.id, post_id: @first_post.id,
                                  text: 'This the sixth comment for first post')

    Like.create(author_id: @first_user.id, post_id: @first_post.id)
    Like.create(author_id: @second_user.id, post_id: @first_post.id)
    Like.create(author_id: @third_user.id, post_id: @first_post.id)

    visit user_posts_path(@first_user, @first_post)
  end

  scenario 'should show posts title' do
    expect(page).to have_content('The first post')
  end

  scenario 'should show post author name' do
    expect(page).to have_content('Sameed Mohsin')
  end

  scenario 'should show number of comments for the post' do
    expect(page).to have_content('Comments: 6')
  end

  scenario 'should show the number of likes for the post' do
    expect(page).to have_content('Likes: 3')
  end

  scenario 'should show the text content' do
    expect(page).to have_content('Content for the first post')
  end

  scenario 'should show user name of each comment' do
    within('.bg') do
      expect(page).to have_content('Sameed Mohsin')
      expect(page).to have_content('Barber John')
      expect(page).to have_content('Akeem Fauzi')
    end
  end

  scenario 'should show each comment for the post' do
    within('.bg') do
      expect(page).to have_content('This the sixth comment for first post')
      expect(page).to have_content('This the fifth comment for first post')
      expect(page).to have_content('This the fourth comment for first post')
      expect(page).to have_content('This the third comment for first post')
      expect(page).to have_content('This the second comment for first post')
    end
  end
end
