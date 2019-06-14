class ConversationsController < ApplicationController
    # before_action(:logged_in_user, only: [:create, :show])
    # layout false
    def create
        if Conversation.between(params[:sender_id],params[:recipient_id]).present?
            @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
          else
            @conversation = Conversation.create!(conversation_params)
          end
      
          render json: { conversation_id: @conversation.id }
    end
    def show
       @conversation = Conversation.find(params[:id])
       @reciver = interlocutor(@conversation)
       @messages = @conversation.messages
       @message = Message.new
    end
    private
    def conversation_params
       params.require(:conversation).permit(:sender_id, :recipient_id)
    end
end
