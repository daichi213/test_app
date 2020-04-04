class LikesController < ApplicationController
  def add
    @post = Post.find_by id: params[:post_id]
    @like = Like.new(post_id: params[:post_id] , user_id: @current_user.id)
    #カンニングポイント
    @like.save
    #redirect_toの引数に用いている変数はリダイレクト先の@postで使用する。今回の場合はアクション内で@postを定義していないため、新たに定義し直す必要がある。
    redirect_to posts_show_path(@post)
  end

  def destroy
    @post = Post.find_by id: params[:post_id]
    @like = Like.find_by(post_id: params[:post_id] , user_id: @current_user.id)
    #カンニングポイント
    @like.destroy
    redirect_to posts_show_path(@post)
  end
end