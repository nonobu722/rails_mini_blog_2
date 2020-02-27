class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def followed
    @users = current_user.followed.includes(:posts)
    render 'followed_list'
  end
end
