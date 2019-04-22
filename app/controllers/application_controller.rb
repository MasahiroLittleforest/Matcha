class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  


  private
    def require_user_logged_in
      unless logged_in?
        redirect_to login_url
      end
    end
    
    def university_projects
      University.find_by(id: current_user.university_id).projects.order(created_at: :DESC).page(params[:page]).per(20)
    end
    
    def set_search
      @search = university_projects.ransack(params[:q])
    end
end
