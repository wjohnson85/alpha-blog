class UsersController < ApplicationController
    # before these controller show, edit, update actions run the set_user private method
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]


    def show
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
            # after use is saved log them in
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to the Alpha Blog #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def edit
      
    end
        
    def update
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

    def destroy
        @user.destroy
        session[:user_id] = nil if @user = current_user
        flash[:notice] = "Account and articles deleted"
        redirect_to articles_path
    end

private 
# define user_params whitelist email and password
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
         # assign user to instance variable based on id from params hash
         @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own profile"
            redirect_to @user
    end
end
end
