class UserMailer < ApplicationMailer

   def accont_activation(user)
       greeting = "Hi Human"
       @user = user
       mail to: @user.email, subject: "Active Your Accont" 
   end

   def password_reset(user)
       @user = user
       mail to: @user.email, subject: "Reset Password"
   end

end
