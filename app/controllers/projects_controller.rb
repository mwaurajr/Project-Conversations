class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :update_status]

  def index
    @projects = current_user.projects.order(updated_at: :desc)
  end

  def show
    @conversation_items = @project.conversation_items
    @comment = Comment.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params.except(:status))
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  def update_status
    if @project.update_status(params[:status], current_user)
      respond_to do |format|
        format.html { redirect_to @project, notice: "Status was successfully updated." }
        format.turbo_stream
      end
    else
      redirect_to @project, alert: "Failed to update status."
    end
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :status)
  end
end
