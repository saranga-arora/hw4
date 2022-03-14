class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    entered_email = params["user"]["email"]
    entered_username = params["user"]["username"]

    @check_email = User.find_by({email: entered_email})
    @check_username = User.find_by({username: entered_username})

    if @check_username #check if username exists
      flash[:notice] = "This username already exists."
      redirect_to "/users/new"
    elsif @check_email #check if email exists
      flash[:notice] = "This email is already registered."
      redirect_to "/users/new"
    else
      plain_text_password = params["user"]["password"]
      @user = User.new(params["user"])
      @user.password = BCrypt::Password.create(plain_text_password)
      @user.save
      session["user_id"] = @user.id
      redirect_to "/"
    end 
    
  end
end
