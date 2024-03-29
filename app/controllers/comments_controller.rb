class CommentsController < ApplicationController
  load_and_authorize_resource
  def index
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comments = @post.comments
    respond_to do |format|
      format.html
      format.json { render json: @comments, status: 200 }
    end
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      # redirect_to previous url link or page if available using  redirect_to request.referrer
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.json { render json: @comment, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :create }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    # redirect_to previous url link or page if available
    redirect_to request.referrer
  end
  private :comment_params
end
