class LikesController < ApplicationController
  before_action :set_comment

  def create
    @like = @comment.likes.build(user: current_user)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @project }
        format.turbo_stream
      else
        format.html { redirect_to @project }
      end
    end
  end

  def destroy
    @like = @comment.likes.find_by(user: current_user)
    @like.destroy if @like

    respond_to do |format|
      format.html { redirect_to @project }
      format.turbo_stream
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
    @project = @comment.project
  end
end
