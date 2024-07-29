class JoinRequestsController < ApplicationController
  before_action :set_group
  before_action :set_join_request, only: [:destroy, :approve, :reject, :re_request]

  def create
    @join_request = @group.join_requests.build(user: current_user, status: "pending")
    if @join_request.save
      redirect_to post_path(@group.post), notice: '参加申請を送信しました。'
    else
      redirect_to post_path(@group.post), alert: '参加申請の送信に失敗しました。'
    end
  end

  def re_request
     @join_request.update(status: "pending")
    redirect_to post_path(@group.post), notice: '参加申請を送信しました。'
  end

  def destroy
    @join_request.update(status: "canceled")
    redirect_to post_path(@group.post), notice: '参加申請をキャンセルしました。'
  end

  def approve
    @join_request.update(status: :approved)
    redirect_to post_path(@group.post), notice: '参加申請を承認しました。'
  end

  def reject
    @join_request.update(status: :rejected)
    redirect_to post_path(@group.post), notice: '参加申請を拒否しました。'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_join_request
    @join_request = @group.join_requests.find(params[:id])
  end
end