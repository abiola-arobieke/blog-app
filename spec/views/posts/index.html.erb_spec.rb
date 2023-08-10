require 'rails_helper'

RSpec.feature 'Post index page', type: :feature do
  before do
    @first_user = User.create(name: 'Akeem Fauszi', bio: 'He is a developer',
                              photo: 'https://avatars.githubusercontent.com/u/114492335?v=4',
                              posts_counter: 0)

    @first_post = Post.create(author: @first_user, title: 'The first post',
                              text: 'Content for the first post', comments_counter: 0,
                              likes_counter: 0)
    @second_post = Post.create(author: @first_user, title: 'The second post',
                               text: 'Content for the second post', comments_counter: 0,
                               likes_counter: 4)
    @third_post = Post.create(author: @first_user, title: 'The third post',
                              text: 'Content for the third post', comments_counter: 0,
                              likes_counter: 0)
    @fourth_post = Post.create(author: @first_user, title: 'The fourth  post',
                               text: 'Content for the fourth post', comments_counter: 0,
                               likes_counter: 0)

    @first_comment = Comment.create(author_id: @first_user.id, post_id: @first_post.id,
                                    text: 'This the first comment for first post')
    @second_comment = Comment.create(author_id: @first_user.id, post_id: @first_post.id,
                                     text: 'This the second comment for first post')
    @third_comment = Comment.create(author_id: @first_user.id, post_id: @first_post.id,
                                    text: 'This the third comment for first post')
    @fourth_comment = Comment.create(author_id: @first_user.id, post_id: @first_post.id,
                                     text: 'This the fourth comment for first post')
    @fifth_comment = Comment.create(author_id: @first_user.id, post_id: @first_post.id,
                                    text: 'This the fifth comment for first post')
    @six_comment = Comment.create(author_id: @first_user.id, post_id: @first_post.id,
                                  text: 'This the sixth comment for first post')

    visit user_posts_path(@first_user)
  end

  scenario 'should display user profile image' do
    expect(page).to have_css("img[src*='https://avatars.githubusercontent.com/u/114492335?v=4']")
  end

  scenario 'should display user name, and its number of post' do
    expect(page).to have_content('Akeem Fauszi')
    expect(page).to have_content('Number of posts: 4')
  end

  scenario 'should show all the posts title' do
    expect(page).to have_content('The first post')
    expect(page).to have_content('The second post')
    expect(page).to have_content('The third post')
    expect(page).to have_content('The fourth post')
  end

  scenario 'should show some of the post text' do
    expect(page).to have_content('Content for the first post')
    expect(page).to have_content('Content for the second post')
    expect(page).to have_content('Content for the third post')
    expect(page).to have_content('Content for the fourth post')
  end

  scenario 'should display five most recent comments for a post' do
    expect(page).to have_content('This the sixth comment for first post')
    expect(page).to have_content('This the fifth comment for first post')
    expect(page).to have_content('This the fourth comment for first post')
    expect(page).to have_content('This the third comment for first post')
    expect(page).to have_content('This the second comment for first post')
    expect(page).not_to have_content('This the first comment for first post')
  end

  scenario 'should show number of comments for a post' do
    expect(page).to have_content('Comments: 6')
    expect(page).to have_content('Comments: 0', count: 3)
  end

  scenario 'should show the number of likes for a post' do
    expect(page).to have_content('Likes: 4')
    expect(page).to have_content('Likes: 0', count: 3)
  end

  scenario 'should redirects to the post detail page when a post is clicked' do
    click_link @second_post.title
    expect(page).to have_current_path(user_post_path(@first_user, @second_post))
  end
end
