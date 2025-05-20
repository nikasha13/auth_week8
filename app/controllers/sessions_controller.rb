class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  # when the user submits a form, this is where the code goes
  def create
    # authenticate the user
    # 1. try to find the user by their unique identifier (HAS TO BE UNIQUE)
    @user = User.find_by({"email" => params["email"]})
    # 2. if the user exists -> check if they know their password
    if @user != nil
    # 3. if they know their password -> login is successful
      if BCrypt::Password.new(@user["password"]) == params["password"]
        #add a cookie here
        #cookies["monster"] = "me like cookies"
        # flash is a one-time use cookie
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome."
        redirect_to "/companies"
      else 
        flash["notice"] = "Nope."
        redirect_to "/login"
      end
    else
    # 4. if the user doesn't exist or they don't know their password -> login fails
    flash["notice"] = "Nope."
    redirect_to "/login"
    end
  end

  def destroy
    # logout the user / kills the cookie so nav bar changes
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
