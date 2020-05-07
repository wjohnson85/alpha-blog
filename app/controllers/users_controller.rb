class UsersController < ApplicationController

    def show
        # assign user to instance variable based on id from params hash
        @user = User.find(params[:id])
        # assign all articles from that use to an instance varible to be used in the views
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end   

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

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

    def edit
        @user = User.find(params[:id])
        
    end
        
    def update
        # find user and assign it to user instance variable
        @user = User.find(params[:id])
        if @user.update(user_params)
            # if the user updates show a success message
            flash[:notice] = "Account updated"
            #redirect to @user we assigned on line 36
            redirect_to @user
        else
            # if doesn't update show the edit page again
            render 'edit'
        end
    end

private 
# define user_params whitelist email and password
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end
