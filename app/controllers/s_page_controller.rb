class SPageController < ApplicationController
  def home
    if logged_in? then
       @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end
