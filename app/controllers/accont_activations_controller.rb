class AccontActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && authenticated?(:activation, params[:id])
            activate
            login(user)
            flash[:success] = "Accont Activated"
            redirect_to(user)
        else 
            flash[:danger] = "Token Expired"
            redirect_to(root_url)
        end
    end
end
