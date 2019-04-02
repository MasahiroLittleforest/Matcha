class ProjectFavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    project = Project.find(params[:project_id])
    current_user.like(project)
    flash[:success] = 'プロジェクトをお気に入りに登録しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    project = Project.find(params[:project_id])
    current_user.unlike(project)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
