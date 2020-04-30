class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_requests

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  private

  def set_requests
    @pending = current_user.pending_requests
    @recieved = current_user.recieved_requests
  end
end
