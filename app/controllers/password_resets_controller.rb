class PasswordResetsController < ApplicationController
  before_action(:get_user, only: [:edit, :update])
  before_action(:valid_user, only: [:edit, :update])
  before_action(:check_expire, only: [:edit, :update])
  def new
  end
  
  def create
     @user = User.find_by(email: params[:password_reset][:email].downcase)
     if @user then
         @user.create_reset_digest
         @user.send_reset_digest
         flash[:success] = "Email Send Check Your Email"
         redirect_to(login_path)
     else
         flash[:danger] = "Email Not Found Please Login MyFriend"
         redirect_to(login_path)
     end
  end

  def edit
  end

  def update
     if params[:user][:password].empty? then
         @user.errors.add(:user, "Password Cant Be Blank")
         render('edit')
     elsif @user.update_attributes(user_params)
        login(@user)
        @user.update_attribute(:reset_digest, nil) 
        flash[:success] = "Password Reset"
        redirect_to(@user)
     else
        redner("edit")
     end

  end
  private
  def user_params
      params.require(:user).permit(:password, :password_confirmation)
  end
  def get_user
     @user = User.find_by(email: params[:email])
  end

  def valid_user
     unless @user && @user.activated? && @user.authenticated?(:reset, params[:id]) then
        flash[:danger] = "User Not Activated"
        redirect_to(root_url)
     end
  end
  def check_expire
     if @user.reset_token.expired? then
        flash[:warning] = "Token Expired"
        redirect_to(new_password_reset_path)
     end
  end
end
