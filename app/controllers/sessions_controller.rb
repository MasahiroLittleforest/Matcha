class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインしました。'
      redirect_to projects_url
    else
      flash.now[:danger] = 'ログインできませんでした。'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  def sample_login
    email = "matcha@example.com"
    password = "matchamatcha"
    if login(email, password)
      flash[:success] = 'ログインしました。'
      redirect_to projects_url
    else
      flash.now[:danger] = 'ログインできませんでした。'
      render 'new'
    end
  end
end
