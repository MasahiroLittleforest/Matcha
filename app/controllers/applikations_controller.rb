class ApplikationsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    project = Project.find(params[:project_id])
    current_user.participate(project)
    flash[:success] = 'プロジェクトに参加しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def cancel
    project = Project.find(params[:id])
    current_user.cancel(project)
    flash[:success] = 'プロジェクトへの参加をキャンセルしました。'
    redirect_back(fallback_location: root_path)
  end
  
  def rejoin
    project = Project.find(params[:id])
    current_user.rejoin(project)
    flash[:success] = 'プロジェクトへ再び参加しました。'
    redirect_back(fallback_location: root_path)
  end
end
