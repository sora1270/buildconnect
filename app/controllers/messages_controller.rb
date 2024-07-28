class MessagesController < ApplicationController
  before_action :set_group

  def create
    @message = @group.messages.build(message_params)
    @message.user = current_user
    if @message.save
      redirect_to @group.post, notice: 'メッセージが送信されました。'
    else
      redirect_to @group.post, alert: 'メッセージの送信に失敗しました。'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end