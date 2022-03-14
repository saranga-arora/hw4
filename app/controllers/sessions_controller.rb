class SessionsController < ApplicationController
  def new
  end

  def create
    entered_email = params["email"]
    entered_password = params["password"]

    #check if there is user with that email in database
    @user = User.find_by({email: entered_email})

    #now, if email matches, check the passowrd
    if @user 
      if BCrypt::Password.new(@user.password) == entered_password
        session["user_id"] = @user.id 
        flash[:notice] = "Welcome!"
        redirect_to "/places"
      else 
        flash[:notice] = "Password is incorrect."
        redirect_to "/sessions/new"
      end 
      else 
      flash[:notice] = "No user with that email address."
      redirect_to "/sessions/new"
      end
  end

  def destroy
    session["user_id"] = nil
    flash[:notice] = "You have been logged out"
    redirect_to "/sessions/new"
  end
end