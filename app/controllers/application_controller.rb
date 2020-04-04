class ApplicationController < ActionController::Base
    before_action :current_user

    def current_user
        @current_user = User.find_by id: session[:user_id]
    end

    def user_authenticate
        if @current_user.id == nil
            flash[:notice] = "ログインが必要です"
            redirect_to user_login_path
        end
    end

    def user_login_message
        if @current_user
            flash[:notice] = "すでにログインしています"
            redirect_to posts_index_path
        end
    end
end
