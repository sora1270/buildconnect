class GroupMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    @membership = @group.group_memberships.build(user: current_user)
    if @membership.save
      redirect_to @group, notice: 'グループに参加申請を送りました。'
    else
      redirect_to @group, alert: '参加申請に失敗しました。'
    end
  end

  def update
    @membership = @group.group_memberships.find(params[:id])
    if @membership.update(status: params[:status])
      redirect_to @group, notice: '参加申請が更新されました。'
    else
      redirect_to @group, alert: '参加申請の更新に失敗しました。'
    end
  end

  def destroy
    @membership = @group.group_memberships.find(params[:id])
    @membership.destroy
    redirect_to @group, notice: 'グループから退出しました。'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end