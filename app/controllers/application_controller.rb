class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  


  private
    def require_user_logged_in
      unless logged_in?
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find_by(id: params[:id])
      @project = Project.find_by(id: params[:id])
      @comment_to_project = CommentToProject.find_by(id: params[:id])
      unless @user == current_user || @project == current_user.projects || @comment_to_project == current_user.comment_to_projects
        redirect_to root_url
      end
    end
    
    def university_projects
      University.find_by(id: current_user.university_id).projects.order(created_at: :DESC).page(params[:page]).per(20)
    end
    
    def set_search
      @search = university_projects.ransack(params[:q])
    end
end
