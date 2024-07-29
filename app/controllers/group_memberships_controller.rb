class GroupMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post_and_group

  def index
    @memberships = @group.join_requests.where(status: :approved).includes(:user)
  end
  
  private

  def set_post_and_group
    @post = Post.find(params[:post_id])
    @group = Group.find(params[:group_id])
  end
end