require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'User Test', photo: 'link', bio: 'Test Like model', posts_counter: 0) }
  let(:post) do
    Post.create(author_id: user.id, title: 'Microverse', text: 'Ruby on Rails module', comments_counter: 0,
                likes_counter: 0)
  end

  it 'should belong to a user' do
    expect(Like.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it 'should belong to a post' do
    expect(Like.reflect_on_association(:post).macro).to eq(:belongs_to)
  end

  it 'should increment the likes counter of the associated post when the like is created' do
    expect do
      Like.create(user_id: user.id, post_id: post.id)
    end.to change { post.reload.likes_counter }.by(1)
  end

  it 'should increment the likes counter of the associated post when the like is updated' do
    post.likes_counter = 0
    like = Like.create(user_id: user.id, post_id: post.id)
    like.update(user_id: user.id, post_id: post.id)

    expect(post.reload.likes_counter).to eq(1)
  end
end
