class SessionController < ApplicationController
  def new
  end
  def create
      user = User.find_by(name: params[:session][:name].downcase)
      if user && user.authenticate(params[:session][:password]) then
          if user.activated?
             login(user)
             params[:session][:remember_form] == '1' ? remember(user) : forget(user)
             flash[:info] = "Wellcome Mr Or Miss"
             #redirect_to some_path
             redirect_to users_path
          else
            flash[:danger] = "Accont Not Activated"
            redirect_back_or user
          end   
      else
          flash[:danger] = "Wrong name or Pass"
          # render('new')
          redirect_to root_url
      end
  end

  def destroy
    logout
    redirect_to(login_path)
  end
end
