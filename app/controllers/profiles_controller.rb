class ProfilesController < ApplicationController

    def create
        @profile = Profile.new(profile_params)
        @profile.user_id = current_user.id

         @profile.save

        redirect_to user_path(@profile.user)
    end

    def update
        @user = User.find(params[:user_id])
        @profile = @user.profile
        @profile.update(profile_params)

        redirect_to user_path(@profile.user)
    end

    private
    
    def profile_params
        params.require(:profile).permit(:image, :name, :about)
    end
end
