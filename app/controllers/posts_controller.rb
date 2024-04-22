class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
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

  private
  
  def post_params
    params.require(:post).permit(:post_content)
  end
end
