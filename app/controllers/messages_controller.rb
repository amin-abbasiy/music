class MessagesController < ApplicationController
    def create
       @conversation = Conversation.find(params[:conversation_id])
       @message = @conversation.messages.build(msg_params)
       @message.user_id = curerent_user.id
       @message.save!

       @path = conversation_path(@conversation)
    end

    private
    def msg_params
       params.require(:message).permit(:body)
    end
end
