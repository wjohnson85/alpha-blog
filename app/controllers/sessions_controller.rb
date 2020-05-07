class SessionsController < ApplicationController 

def create
    # find the User in the database using the email that comes from the params
    user = User.find_by(email: params[:session][:email].downcase)
    # test if user was found and  the password in correct
    if user && user.authenticate(params[:session][:password])
    # use session object to store user id of the user who has just been authenticated
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to user
    else 
    # flash persist for one full http request but .now doesnt persist it displays then disappers 
    flash.now[:alert] = "There something wrong with your login details"    
    render 'new'    
end

def new
end

def destroy
    # set user id to nil to loggged user out and redirect to home page
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
end

end
end