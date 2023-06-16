class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :set_user, only: [:index, :create, :show]

  def index
    @posts = @user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      flash[:notice] = 'Post was successfully created'
      redirect_to user_post_url(@user, @post)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
