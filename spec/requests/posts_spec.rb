require 'rails_helper'

describe 'Users', type: :request do
  let(:user1) do
    User.create(
      name: 'Alfred Dune',
      photo: 'https://unsplash.com/photos/USAT3jVsYIc',
      posts_counter: 0
    )
  end

  let(:post1) do
    Post.create(
      author: user1,
      title: 'The sailor',
      text: 'Compass and anchor',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  let(:post2) do
    Post.create(
      author: user1,
      title: 'The brown roof',
      text: 'Brown roofs are caused mainly by rust',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  before do
    user1
    post1
    post2
  end

  describe 'GET/index' do
    it 'renders all post for a certain user' do
      get "/users/#{user1.id}/posts"
      expect(response).to have_http_status(:success)
      expect(response).to be_successful
      expect(response).to render_template 'posts/index'
      expect(response.body).to include('Alfred Dune')
      expect(response.body).to include('The sailor')
      expect(response.body).to include('The brown roof')
    end

    describe 'GET/show' do
      it 'shows details for a particular post' do
        get "/users/#{user1.id}/posts/#{post2.id}"
        expect(response).to have_http_status(:success)
        expect(response).to be_successful
        expect(response).to render_template 'posts/show'
        expect(response.body).to include('Brown roofs are caused mainly by rust')
        expect(response.body).to_not include('The sailor')
      end
    end
  end
end
