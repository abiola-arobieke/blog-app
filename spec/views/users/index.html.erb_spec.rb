require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  before do
    @first_user = User.create(name: 'Frank Lebron', bio: 'The first post from frank', photo: 'https://placekitten.com/200/200',
                              posts_counter: 2)
    @second_user = User.create(name: 'Barber John', bio: 'Barber is a football player', photo: 'https://placekitten.com/200/200',
                               posts_counter: 1)
    @third_user = User.create(name: 'Akeem Fauzi', bio: 'He is a rails developer', photo: 'https://placekitten.com/200/200',
                              posts_counter: 4)
    visit users_path
  end

  scenario 'should show the username of all users' do
    expect(page).to have_content('Frank Lebron')
    expect(page).to have_content('Barber John')
    expect(page).to have_content('Akeem Fauzi')
  end
  scenario 'should show the count of post for each user' do
    expect(page).to have_content('Number of posts: 2')
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('Number of posts: 4')
  end

  scenario 'should display the picture of each user' do
    expect(page).to have_css("img[src*='https://placekitten.com/200/200']", count: 3)
  end

  scenario 'should redirect to the second user profile page' do
    click_link @second_user.name
    expect(page).to have_current_path(user_path(@second_user))
  end

  scenario 'redirect to the user show page' do
    click_link @third_user.name
    expect(page).to have_current_path(user_path(@third_user))
  end
end
