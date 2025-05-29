class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
   # Find the user by their unique email
    @user = User.find_by({ "email" => params["email"] })
   # If the user exists, check if they know their password
    if @user != nil
   # If they know their password then login is successful
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}!"
        redirect_to "/places"
      else
    # If they don't know their password then login fails
        flash["notice"] = "Invalid Login"
        redirect_to "/login"
      end
    else
    # If the user doesn't exist, then login fails
      flash["notice"] = "User Does Not Exist"
      redirect_to "/login"
    end
  end

  def destroy
  #Log Out
  user = User.find_by(id: session["user_id"])
    if user != nil
    flash["notice"] = "Goodbye, #{user.username}!"
    end
  session["user_id"] = nil
  redirect_to "/login"
  end
end

  