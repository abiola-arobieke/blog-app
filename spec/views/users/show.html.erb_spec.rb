require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  before do
    @first_user = User.create(name: 'Frank Lebron F', bio: 'The first post from Frank',
                              photo: 'https://avatars.githubusercontent.com/u/114492335?v=4',
                              posts_counter: 2)

    @first_post = Post.create(author: @first_user, title: 'The first post by Frank', text: 'The first content',
                              comments_counter: 1, likes_counter: 8)
    @second_post = Post.create(author: @first_user, title: 'The second post', text: 'Number 2 content',
                               comments_counter: 2, likes_counter: 7)
    @third_post = Post.create(author: @first_user, title: 'The third post', text: 'The third content',
                              comments_counter: 3, likes_counter: 6)
    @fourth_post = Post.create(author: @first_user, title: 'The fourth post', text: 'My fourth content',
                               comments_counter: 4, likes_counter: 5)

    visit user_path(@first_user.id)
  end

  scenario 'should display user profile picture' do
    expect(page).to have_css("img[src*='https://avatars.githubusercontent.com/u/114492335?v=4']")
  end

  scenario 'should show user name and bio' do
    expect(page).to have_content('Frank Lebron F')
    expect(page).to have_content('The first post from Frank')
  end

  scenario 'should show the number of post for a user' do
    expect(page).to have_content('Number of posts: 4')
  end

  scenario 'should show three most recent user posts' do
    expect(page).to have_content('My fourth content')
    expect(page).to have_content('The third content')
    expect(page).to have_content('The second post')
    expect(page).not_to have_content('The first post by Frank')
  end

  scenario 'should show a link to add new post' do
    expect(page).to have_link('Add New Post')
  end

  scenario 'should show a link to view all post by a user' do
    expect(page).to have_link('See all posts')
  end

  scenario 'show redirects to the post detail page' do
    click_link Post.last.title
    expect(page).to have_current_path(user_post_path(@first_user.id, @fourth_post.id))
  end

  scenario 'redirects to the posts index page' do
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(@first_user.id))
  end
end
