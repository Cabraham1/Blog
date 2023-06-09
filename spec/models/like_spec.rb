require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'User Test', photo: 'link', bio: 'Test Like model', posts_counter: 0) }
  let(:post) { Post.create(author_id: user.id, title: 'Microverse', text: 'Ruby on Rails module', comments_counter: 0, likes_counter: 0) }

  it 'should belong to a user' do
    expect(Like.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it 'should belong to a post' do
    expect(Like.reflect_on_association(:post).macro).to eq(:belongs_to)
  end

  it 'should increment the likes counter of the associated post' do
    expect {
      Like.create(user_id: user.id, post_id: post.id)
    }.to change { post.reload.likes_counter }.by(1)
  end
end
