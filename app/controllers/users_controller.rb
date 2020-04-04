class UsersController < ApplicationController
  before_action :access_restriction , only: [:edit , :regist]
  before_action :user_authenticate , only: [:edit , :regist]
  before_action :user_login_message , only: [:login_form , :login]
  before_action :double_regist , only: [:new , :signup]

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def signup
    @user = User.new(name: params[:name] , email: params[:email] ,password: params[:password])
    if @user.save
      @user.image_name = "default.jpg"
      redirect_to posts_index_paths
      @user.save
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

  def edit
    @user = User.find params[:id]
  end

  def regist
    @user = User.find params[:id]
    #以下画像のアップロードを行った際にユーザー詳細ページでユーザー画像が表示されない問題が発生
    #原因は@user.saveを行っていないことにあり、コンソールよりimage_nameカラムのレコードがnilになっていたことから原因がわかった
    if params[:image]
      image = params[:image]
      @user.image_name = "#{@user.id}.jpg"
      File.binwrite "public/image/#{@user.image_name}" , image.read
      @user.save
    end
    redirect_to posts_index_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def access_restriction
    @user = User.find_by id: params[:id]
    if @user.id != @current_user.id
      flash[:notice] = "アクセス権限がありません"
      redirect_to posts_index_path
    end
  end

  def double_regist
    if @current_user
      flash[:notice] = "すでにユーザー登録しています"
      redirect_to posts_index_path
    end
  end

end
