require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                          posts_counter: 0)
      @post1 = Post.create(author: @user, title: ' we are out side', text: 'This is my first post', likes_counter: 0,
                           comments_counter: 0)
      @post2 = Post.create(author: @user, title: 'Hello Two', text: 'This is my second post', likes_counter: 0,
                           comments_counter: 0)
      @post3 = Post.create(author: @user, title: 'Hello Three', text: 'This is my third post', likes_counter: 0,
                           comments_counter: 0)
      visit user_path(@user)
    end

    it "renders user's profile picture" do
      find("img[src='#{@user.photo}']")
    end

    it "renders the user's username" do
      expect(page).to have_content(@user.name)
    end

    it "renders the user's post count" do
      expect(page).to have_content(@user.posts_counter)
    end

    it "renders the user's bio" do
      expect(page).to have_content(@user.bio)
    end

    it 'renders 3 recent posts of the user' do
      expect(page).to have_content(@post1.title)
      expect(page).to have_content(@post2.title)
      expect(page).to have_content(@post3.title)
    end

    it 'renders a button to redirect to posts page' do
      expect(page).to have_content('See all posts')
    end

    it "redirects to the user's posts index page" do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
