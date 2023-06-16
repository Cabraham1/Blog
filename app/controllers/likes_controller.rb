class LikesController < ApplicationController
  def create
    @like = Like.new(post_id: params[:post_id], user_id: current_user.id)
    begin
      @like.save!
      redirect_to user_post_path(params[:user_id], params[:post_id])
    rescue ActiveRecord::RecordInvalid
      render :error, status: :unprocessable_entity
    end
  end
end
