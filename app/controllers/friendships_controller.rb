class FriendshipsController < ApplicationController

  def create
    @friend = User.find(friendship_params[:user_id])
  
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
    @friend = User.find(friendship_params[:user_id])
    if current_user.accept_request(@friend)
      flash[:notice] = "Friend request accepted"
    else
      flash[:alert] = "Error accepting friend request"
    end
    redirect_to users_path
  end

  def reject
    @friend = User.find(friendship_params[:user_id])
    if current_user.reject_request(@friend)
      flash[:notice] = "Friend request rejected"
    else
      flash[:alert] = "Error rejecting friend request"
    end
    redirect_to users_path
  end

  def friendship_params
    params.require(:friendship).permit(:user_id)
  end
end
