class CommentsController < ApplicationController
  def create
     @song = Song.find(params[:song_id])
     @comment = @song.comments.build(comment_param) do |object|
     object.user_id = current_user.id
     end
     if @comment.save then
         flash[:success] = "Comment Added"
         redirect_to request.referrer
     else

     end
  end

  def edit
  end

  private
  def comment_param
     params.require(:comment).permit(:content)
  end
end
