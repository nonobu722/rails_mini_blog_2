class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      NotificationMailer.notify(@post.user).deliver_later
      redirect_to post_path(params[:post_id]), notice: t('notice.new_comment')
    else
      flash.now[:alert] = t('alert.new_comment')
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end
