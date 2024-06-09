class PostsController < ApplicationController
  before_action :require_login
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
    @has_post_history = current_user.posts.exists?
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿が完了しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "投稿が更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿が削除されました。"
  end

  def history
    @posts = current_user.posts.order(created_at: :desc)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    redirect_to posts_path, alert: "権限がありません。" unless @post.user == current_user
  end
  
  def post_params
    params.require(:post).permit(:post_content)
  end
end
