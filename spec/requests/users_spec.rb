require 'rails_helper'

describe 'Users', type: :request do
  let(:user1) do
    User.create(
      name: 'Alfred Dune',
      photo: 'https://unsplash.com/photos/USAT3jVsYIc',
      posts_counter: 0
    )
  end

  let(:user2) do
    User.create(
      name: 'Sisi Brooke',
      photo: 'https://unsplash.com/photos/vMmuvnlXISE',
      posts_counter: 0
    )
  end

  before do
    user1
    user2
  end

  describe 'GET/index' do
    it 'renders all users' do
      get '/users'
      expect(response).to render_template 'users/index'
      expect(response.body).to include('Alfred Dune')
      expect(response.body).to include('Sisi Brooke')
      expect(response).to have_http_status(:success)
      expect(response).to be_successful
    end

    describe 'GET/show' do
      it 'shows details for a given user' do
        get "/users/#{user2.id}"
        expect(response).to render_template 'users/show'
        expect(response.body).to include('Sisi Brooke')
        expect(response).to have_http_status(:success)
        expect(response).to be_successful
      end
    end
  end
end
