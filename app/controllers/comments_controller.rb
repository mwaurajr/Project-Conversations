class CommentsController < ApplicationController
  before_action :set_project
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @project.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @project, notice: "Comment was successfully added." }
        format.turbo_stream
      else
        format.html { redirect_to @project, alert: "Failed to add comment." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_comment", partial: "comments/form", locals: {project: @project, comment: @comment}) }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @project, notice: "Comment was successfully removed." }
      format.turbo_stream
    end
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_comment
    @comment = @project.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id, :image)
  end
end
