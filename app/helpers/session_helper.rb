module SessionHelper
    def login(user)
       session[:user_id] = user.id
    end
    def remember(user)
       user.remember
       cookies.permanent.signed[:user_id] = user.id
       cookies.permanent[:remember_form] = user.remember_token
    end
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remeber_token)
    end
    def current_user
        if user_id = session[:user_id] then
            @current_user ||= User.find_by(id: user_id)
        elsif user_id = cookies.permanent.signed[:user_id]
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:login, cookies[:remember_token]) then
                login(user)
                @current_user = user
            end
        end
    end
    def logged_in?
        !current_user.nil?
    end
    def logout
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end
    def current_user?(user)
       if @current_user == user then
         return true
       else
         return false
       end
    end

    def find_user(user)
       @user = User.find(user)
       return @user.name
    end
    def current_song(songe)
       @songe = songe
    end
    def song_h
       @songe
    end
    # def like
    #     song = Song.find(params[:id])
    #     final = song.like += 1
    #     song.update(like: final)
    # end
end
