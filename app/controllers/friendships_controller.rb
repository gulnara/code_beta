class FriendshipsController < ApplicationController
  def create
    @friendship =  current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      redirect_to root_url, :notice => "Successfully added friend."
    else
      redirect_to root_url, :notice => "Can't create a friend"
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to root_url, :notice => "Successfully destroyed friendship."
  end
end
