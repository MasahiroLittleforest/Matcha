class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_search, only: [:index, :show, :edit, :followings, :followers, :likes, :participatings]
  
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @not_cancelled_paticipatings = Project.joins(:reverses_of_applikation).where(applikations: { user_id: @user.id, cancel: false }).group(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      login(@user.email, @user.password)
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー情報を更新できませんでした。'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    flash[:success] = 'アカウントを削除しました。'
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
  end
  
  def participatings
    @user = User.find(params[:id])
    @participatings = @user.participatings.page(params[:page])
  end
  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :university_name, :image, :profile)
    end
end
