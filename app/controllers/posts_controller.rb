class PostsController < ApplicationController
  #onlyにnewアクションを追加したことによって:idの値が見つからずにエラーが発生
  #newアクション自体にアクセス制限をかける必要はないため、以下メソッドを適用外へ変更

  #投稿系のページでcreateアクションにもアクセス制限をかけていたが、createアクション動作前の時点ではuser_idの登録が完了していないため、Post.userの実行でエラーが発生した
  #createアクションに関してもsessionを使用しているため、不正アクセスすることはないため適用から除外
  before_action :user_access_restriction , only: [:edit , :update , :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
    @like = Like.find_by(post_id: params[:id] , user_id: @current_user.id)
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      redirect_to(posts_index_path)
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      redirect_to(posts_index_path)
    else
      render("posts/show")
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content] , user_id: @current_user.id)
    if @post.save
      redirect_to posts_index_path
    else
      render("posts/new")
    end
  end

  def user_access_restriction
    post = Post.find_by id: params[:id]
    @user = post.user
    if @current_user.id != @user.id
      flash[:notice] = "アクセス権限がありません"
      redirect_to posts_index_path
    end
  end
end
