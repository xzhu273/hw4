class SessionsController < ApplicationController
  def new
  end


  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}."
        redirect_to "/places"
      else
        # if the user doesn't know their password -> login fails
        flash["notice"] = "Unsuccessful login."
        redirect_to "/login"
      end
    else
      # if the user doesn't exist -> login fails
      flash["notice"] = "Unsuccessful login."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    redirect_to "/login"
  end

end


  