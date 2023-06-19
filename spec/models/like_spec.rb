require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'User Test', photo: 'link', bio: 'Test Like model', posts_counter: 0) }
  let(:post) { Post.create(author_id: user.id, title: 'Microverse', text: 'Ruby on Rails module', comments_counter: 0, likes_counter: 0) }
  subject { Like.new(user_id: user.id, post_id: post.id) }

  before { subject.save }

  it 'should increment likes counter for post' do
    prev_counter = subject.post.likes_counter
    subject.increment_likes_counter
    expect(subject.post.likes_counter).to eq(prev_counter + 1)
  end
end
