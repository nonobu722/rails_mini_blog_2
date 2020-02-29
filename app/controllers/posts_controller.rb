class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find_by(id:params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: t('notice.new_post')
    else
      flash.now[:alert] = t('alert.new_post')
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
