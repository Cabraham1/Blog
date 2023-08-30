require 'rails_helper'
RSpec.describe 'Users controller', type: :request do
  it 'renders users page' do
    get '/users'
    expect(response).to have_http_status(:ok)
    expect(response).to render_template(:index)
    expect(response.body).to include('List all users')
  end
  it 'renders a page for specific user' do
    user = User.create(name: 'Tom', photo: 'https://avatars.githubusercontent.com/u/68823331?v=4',
                       bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    get "/users/#{user.id}"
    expect(response).to have_http_status(:ok)
    expect(response).to render_template(:show)
    expect(response.body).to include('Details of a selected user')
  end
end
