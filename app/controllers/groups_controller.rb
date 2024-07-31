class GroupsController < ApplicationController
  before_action :set_post, except: [:members]
  before_action :set_group, only: [:show, :members, :join, :approve, :reject, :destroy]
  before_action :set_join_request, only: [:approve, :reject]

  def show
    @members = @group.members
  end

  def members
    @members = @group.members
  end

  def create
    @group = @post.groups.new(group_params)
    @group.user = current_user
    if @group.save
      redirect_to @post, notice: 'グループが作成されました'
    else
      render 'new'
    end
  end

  def join
    @join_request = @group.join_requests.build(user: current_user)
    if @join_request.save
      redirect_to post_group_path(@post, @group), notice: '参加申請を送信しました。'
    else
      redirect_to post_group_path(@post, @group), alert: '参加申請の送信に失敗しました。'
    end
  end

  def approve
    @join_request = @group.join_requests.build(user: current_user)
    if @join_request.update(status: :approved)
      # メンバーシップを作成
      @group.group_memberships.create(user: @join_request.user)
      redirect_to post_group_group_memberships_path(@post, @group), notice: '参加申請を承認しました。'
    else
      redirect_to post_group_group_memberships_path(@post, @group), alert: '参加申請の承認に失敗しました。'
    end
  end

  def reject
    @join_request = @group.join_requests.build(user: current_user)
    if @join_request.update(status: :rejected)
      redirect_to post_group_group_memberships_path(@post, @group), notice: '参加申請を拒否しました。'
    else
      redirect_to post_group_group_memberships_path(@post, @group), alert: '参加申請の拒否に失敗しました。'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to post_path(@post), notice: 'グループが削除されました。'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def set_join_request
    @join_request = @group.join_requests.find(params[:join_request_id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end