class UsersController < ApplicationController
    before_action(:logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers])
    before_action(:corrent_user, only: [:edit, :update])
    before_action(:is_admin, only: [:destroy])
    #Top Lines Run Before Actions And Its ggod for user validation for valid user
    def index
        @users = User.paginate(page: params[:page])
     # @users = User.all
    end 
    def new
       @user = User.new    
    end
    def create
       @user = User.new(user_params)
       if @user.save
          @user.send_activation_email
          flash[:info] = "Accont Created!"
          redirect_to root_url   
       elsif
          render new_user_path
       end
    end
    def show
       @user = User.find(params[:id])
       @songs = @user.songs.paginate(page: params[:page])
       #for find user by id you cant use find_by method
    end
    def edit
       @user = User.find(params[:id])
    end
    def update
       @user = User.find(params[:id])
       if(@user.update_attributes(edit_params)) then
           flash[:info] = "Updated"
           redirect_to @user
       else
           render 'edit'
       end
    end
    def delete
    
    end
    def deactivate
       @usere = User.find(params[:id])
       @usere.update_attribute(:activated, false)
    end
    def destroy
         User.find(params[:id]).destroy
         flash[:success] = "User Deleted"
         redirect_to users_url
    end
    def following
       @title = "Following"
       @user = User.find(params[:id])
       @users = @user.following.paginate(page: params[:page])
       render 'show_follow'
    end
    def followers
       @title = "Followers"
       @user = User.find(params[:id])
       @users = @user.followers.paginate(page: params[:page])
       render 'show_follow'
    end
    def search
       @user_find = User.find_user(params[:q])
    end
    def usercats
        @cats = Category.all    
    end
    def add_cat
       @cats = params[:pop]
    #    @cats.each do |cat|
          Category.find_by("name = ? ", @cats)
    #    end
    end
    private
    def usercat_params
       params.permit(cat_ids: [])
    end
    def corrent_user
       @user  = User.find(params[:id])
       redirect_to(user_path) unless @user == current_user
    end
    def is_admin
        redirect_to root_url unless current_user.admin?
    end
    def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    def edit_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio)
    end
end
