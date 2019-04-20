class ProjectsController < ApplicationController
  def index
    @all_projects = university_projects
    @fresh_projects = university_projects.where(deadline: DateTime.now..DateTime::Infinity.new, call_off: false, created_at: 1.week.ago..DateTime.now)
    @popular_projects = university_projects.joins(:reverses_of_applikation).where(deadline: DateTime.now..DateTime::Infinity.new, call_off: false).merge(Applikation.where(cancel: false)).group(:project_id).having('count(*) >= 10')
    @closing_soon_projects = university_projects.where(call_off: false, deadline: DateTime.now..5.days.since)
  end

  def show
    @project = Project.find(params[:id])
    @comment_to_projects = CommentToProject.all
    @comment_to_project = CommentToProject.new
    @not_cenceled_participants = User.joins(:applikations).where(applikations: { project_id: @project.id, cancel: false }).group(:user_id)
    @canceled_participants = User.joins(:applikations).where(applikations: { project_id: @project.id, cancel: true }).group(:user_id)
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    
    if @project.save
      flash[:success] = 'プロジェクトを投稿しました。'
      redirect_to @project
    else
      flash.now[:danger] = 'プロジェクトを投稿できませんでした。'
      render :new
    end
  end
  
  def update
    if @project.update(project_params)
      flash[:success] = 'プロジェクトを中止しました。'
      redirect_to @project
    end
  end
  
  def call_off
    @project = Project.find(params[:id])
    @project.update(call_off: true)
    redirect_to @project
  end
  
  def liked_users
    @project = Project.find(params[:id])
    @liked_users = @project.liked_users.page(params[:page])
    counts(@project)
  end
  
  def participants
    @project = Project.find(params[:id])
    @participants = @project.participants.page(params[:page])
    count(@project)
  end
  
  def all_projects
    @all_projects = university_projects
  end
  
  def fresh_projects
    @fresh_projects = university_projects.where(deadline: DateTime.now..DateTime::Infinity.new, call_off: false, created_at: 1.week.ago..DateTime.now).order(created_at: :DESC).page(params[:page]).per(20)
  end
  
  def popular_projects
    @popular_projects = university_projects.joins(:reverses_of_applikation).where(deadline: DateTime.now..DateTime::Infinity.new, call_off: false).merge(Applikation.where(cancel: false)).group(:project_id).having('count(*) >= 10')
  end
  
  def closing_soon_projects
    @closing_soon_projects = university_projects.where(call_off: false, deadline: DateTime.now..5.days.since).order(created_at: :DESC).page(params[:page]).per(20)
  end

  
  
  private
    def project_params
      params.require(:project).permit(:title, :content, :project_category_id, :recruitment_numbers, :all_or_nothing, :deadline, :image, :call_off)
    end
    
    def university_projects
      University.find_by(id: current_user.university_id).projects.order(created_at: :DESC).page(params[:page]).per(20)
    end
end