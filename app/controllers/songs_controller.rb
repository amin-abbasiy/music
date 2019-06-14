class SongsController < ApplicationController
    
    include ActionController::Live
    before_action(:logged_in_user, only: [:create, :edit, :destroy])
    before_action(:corrent_user, only: [:destroy])
    def new
       @song = Song.new
       @cats = Category.all
    end
    def create
      @song = current_user.songs.build(song_params)
      @category = Category.find_by(name: params[:category])
      @song.category_id = @category.id
      if @song.save then
          @tags = params[:tags].split(', ')
          @tags.each do |tag|
             @song.tags.create!(name: tag)
          end
          flash[:success] = "Music Uploaded"
          redirect_to current_user
      else
          flash[:danger] = "Error"
          render('new')
      end
    end

    def show
       
       @song = Song.find(params[:id])
       current_song(@song.id)
       @tags = Tag.where("song_id = ?", @song.id)
       @user = User.find(@song.user_id)
       @comment = Comment.new
       @comments = @song.comments.paginate(page: params[:page])
       
       response.headers['Content-Type'] = 'text/event-stream'
       @song.each do |line|
          response.stream.write line.lyrics
          sleep line.num_beats
       end
       ensure
          response.stream.close
    end
  def edit

  end
  def destroy
      @song.destroy
      flash[:success] = "Post Deleted"
      redirect_to(request.referrer || root_url)
  end
  
  # def search
  #   # terms = params[:s].splite(' ')
  #   @some_song = Song.search(params[:s])
  #   render 'search'
  # end
  def search
    @songs_find = Song.find_query(params[:s])
    render 'search'
  end
  def categories
      @categories = Category.all
      render 'categories'
  end
  def cat_add
    if params[:pop] == 1 then
       @cats = params[:pop]
       Relation.create!(category_id = 1)
    end
  end
  def like
     @like = Like.new(user_id: current_user.id, song_id: params[:sid])
     if @like.save then
         flash[:success] = "Liked"
         redirect_to request.referrer
     else
         redirect_to request.referrer
     end
  end
  private
  def song_params
     params.require(:song).permit(:content, :file, :picture)
  end
  def corrent_user
    @song = current_user.songs.find_by(id: params[:id])
    redirect_to root_url unless @song
  end

end
