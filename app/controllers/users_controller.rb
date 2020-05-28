class UsersController < ApplicationController
 
    def index
        if current_user
        @users = User.all.filter { |i| i if i.id != current_user.id }
        else
         @users = User.all
        end
    end

    def new
        @profile = Profile.new
        @user = current_user
    end

    def show
        @user = User.find(params[:id])
        @profile = @user.profile
        @posts = @user.posts
    end

    def edit
        @user = current_user
        @profile = @user.profile
    end


    def requesting
        current_user.friend_request(User.find(params[:user_id]))
        redirect_to users_path
    end

    def accepted
        current_user.accept_request(User.find(params[:user_id]))
        redirect_to posts_path
    end

    def declining
        current_user.decline_request(User.find(params[:user_id]))
        redirect_to posts_path
    end
end
