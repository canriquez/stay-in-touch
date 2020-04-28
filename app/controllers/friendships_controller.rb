class FriendshipsController < ApplicationController
  before_action :set_user

  def create
    @new_friendship = Friendship.new
    @new_friendship.user_id = current_user.id
    @new_friendship.friend_id = @friend.id
    @new_friendship.status = "requested"

    if @new_friendship.save
      flash[:notice] = "Friend request sent!"
    else
      flash[:alert] = "Error sending friend request"
    end
    redirect_to users_path 
  end

  def accept
    if current_user.accept_request(@friend)
      flash[:notice] = "Friend request accepted"
    else
      flash[:alert] = "Error accepting friend request"
    end
    redirect_to users_path
  end

  def reject
    if current_user.reject_request(@friend)
      flash[:notice] = "Friend request rejected"
    else
      flash[:alert] = "Error rejecting friend request"
    end
    redirect_to users_path
  end

  private
  def friendship_params
    params.require(:friendship).permit(:user_id)
  end

  def set_user
    @friend = User.find(friendship_params[:user_id])
  end
end
