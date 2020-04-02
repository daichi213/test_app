class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def signup
    @user = User.new(name: params[:name] , email: params[:email] ,password: params[:password])
    if @user.save
      redirect_to posts_index_path
    else
      render :new
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email] , password: params[:password])
    if @user
      session[:user_id] = @user.id
      #リダイレクト先にposts_show_path(@user)を指定していたためエラーが発生
      #そもそもここには@postを指定するべき筈なのにこれを指定したのはおかしい
      redirect_to posts_index_path
    else
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to posts_index_path
  end

end
