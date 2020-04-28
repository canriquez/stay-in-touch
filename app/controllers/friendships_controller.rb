class FriendshipsController < ApplicationController

  def create
    puts "HERE"
 
    @friend = User.find(friendship_params[:user_id])
    p @friend
    puts "current user"
    p current_user

    @new_friendship = Friendship.new
    @new_friendship.user_id = current_user.id
    @new_friendship.friend_id = @friend.id
    @new_friendship.status = "requested"

    p @new_friendship

    @new_friendship.valid?
    p @new_friendship.errors.full_messages

    if @new_friendship.save
      flash[:notice] = "Friend request sent!"
    else
      flash[:alert] = "Error sending friend request"
    end
    redirect_to users_path 
  end

  def accept
  end

  def reject
  end

  def friendship_params
    params.require(:friendship).permit(:user_id)
  end
end
