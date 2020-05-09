class ApplicationController < ActionController::Base

    # declares current user as a helper method to be used in the views
    helper_method :current_user, :logged_in?

    def current_user
        # Find user if the used id exists return @current_user if have it already
        @current_user ||= User.find(session[:user_id]) if session[:user_id] 
    end

    def logged_in?
        # check if current_user exists by turning it into a boolean
        !!current_user
    end

    def require_user
        # if used is not logged in will flash a message and redirect to login page
        if !logged_in?
        flash[:alert] = "You must be logged in to perform that action"
        redirect_to login_path
    end
end

end
