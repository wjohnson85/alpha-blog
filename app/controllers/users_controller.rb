class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        # assign new instance varible, if it save show a meesage and redirect
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Welcome to the Alpha Blog #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end

private 
# define user_params whitelist email and password
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end
