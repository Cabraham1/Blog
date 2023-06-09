require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    let(:user) { User.create(name: 'John Doe') }

    it 'is valid with valid attributes' do
      post = user.posts.new(title: 'Lorem ipsum', comments_counter: 2, likes_counter: 3)
      post.author = user # Set the author association
      expect(post).to be_valid
    end

    it 'is not valid with a blank title' do
      post = user.posts.new(title: '', comments_counter: 2, likes_counter: 3)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'is not valid with a title exceeding 250 characters' do
      post = user.posts.new(title: 'a' * 251, comments_counter: 2, likes_counter: 3)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'is not valid with comments_counter as a non-integer or negative value' do
      post = user.posts.new(title: 'Lorem ipsum', comments_counter: 2.5, likes_counter: 3)
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be an integer')

      post.comments_counter = -1
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'is not valid with likes_counter as a non-integer or negative value' do
      post = user.posts.new(title: 'Lorem ipsum', comments_counter: 2, likes_counter: 2.5)
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be an integer')

      post.likes_counter = -1
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end
  end
end
