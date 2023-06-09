require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'User Test', photo: 'link', bio: 'Test Comment model', posts_counter: 0) }
  let(:post) do
    Post.create(author_id: user.id, title: 'Microverse', text: 'Ruby on Rails module', comments_counter: 0,
                likes_counter: 0)
  end

  it 'should belong to a user' do
    expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it 'should belong to a post' do
    expect(Comment.reflect_on_association(:post).macro).to eq(:belongs_to)
  end

  it 'should increment the comments counter of the associated post after creation' do
    expect do
      Comment.create(user_id: user.id, post_id: post.id)
    end.to change { post.reload.comments_counter }.by(1)
  end

  it 'should increment the comments counter of the associated post when the comment is saved' do
    post.comments_counter = 0
    comment = Comment.new(user_id: user.id, post_id: post.id)
    comment.save

    expect(post.reload.comments_counter).to eq(1)
  end
end
