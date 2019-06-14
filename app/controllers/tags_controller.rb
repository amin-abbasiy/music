class TagsController < ApplicationController
    def tags 
        @tags = Tag.where("name = ?", params[:tag])
        @songs = []
        @tags.each do |tag|
            @songs << Song.where("id = ?", tag.song_id)
        end
        render 'tags'
        # @posts = @songs.tags.include?()
    end
end
