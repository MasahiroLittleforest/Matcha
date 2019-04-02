class ProjectsController < ApplicationController
  def index
    @projects = Project.all.page(params[:page])
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    
    if @project.save
      flash[:success] = 'プロジェクトを投稿しました。'
      redirect_to @project
    else
      flash.now[:danger] = 'プロジェクトを投稿できませんでした。'
      render :new
    end
  end
  
  
  private
    def project_params
      params.require(:project).permit(:title, :content, :deadline, :recruitment_numbers, :image)
    end
end
