class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿が完了しました'
    else
      flash.now[:alert] = '投稿は140字以内で入力してください'
      render :new
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
