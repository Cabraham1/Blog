require 'rails_helper'

RSpec.describe 'Users controller', type: :request do
  before(:all) do
    @user = User.create(name: 'Tom', photo: 'https://avatars.githubusercontent.com/u/68823331?v=4',
                        bio: 'Teacher from Mexico.', posts_counter: 0)
  end

  it 'renders posts of a user' do
    get "/users/#{@user.id}/posts"

    expect(response).to have_http_status(:ok)

    expect(response).to render_template(:index)

    expect(response.body).to include('This is the list of posts')
  end

  it 'renders a page for specific post' do
    post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                       comments_counter: 0)
    get "/users/#{@user.id}/posts/#{post.id}"

    expect(response).to have_http_status(:ok)

    expect(response).to render_template(:show)

    expect(response.body).to include('show post for a given user')
  end
end
