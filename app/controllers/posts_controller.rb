class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
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
end
