class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post.favorite(current_user)
    redirect_to root_path
  end

  def destroy
    @post = Favorite.find(params[:id]).post
    @post.unfavorite(current_user)
    redirect_to root_path
  end
end
