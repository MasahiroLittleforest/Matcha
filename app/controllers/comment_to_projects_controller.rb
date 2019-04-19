class CommentToProjectsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]

  
  def index
    @comment_to_projects = CommentToProject.all
  end

  def new
    @comment_to_project = CommentToProject.new
  end

  def create
    @project = Project.find(params[:project_id])
    @comment_to_project = @project.comment_to_projects.build(comment_to_project_params)
    @comment_to_project.user_id = current_user.id
    @comment_to_project.project_id = @project.id
    
    if @comment_to_project.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to "/projects/#{@project.id}"
    else
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
    if @comment_to_project.update(comment_to_project_params)
      flash[:success] = 'コメントを更新しました。'
      redirect_to "/projects/#{@project.id}"
    else
      flash.now[:danger] = 'コメントの更新に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment_to_project = CommentToProject.find_by(id: params[:id])
    @comment_to_project.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  
  
  private
    def comment_to_project_params
      params.require(:comment_to_project).permit(:comment)
    end
    
    def correct_user
      @comment_to_project = current_user.comment_to_projects.find_by(id: params[:id])
      unless @comment_to_project
        redirect_to root_url
      end
    end
end
