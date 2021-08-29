#t.string "instagram_url"
#t.string "facebook_url"
#t.string "my_site"
#t.integer "uploaded_photos"
#t.integer "rating"
#t.string "profile_name"
#t.integer "user_id"

class ProfilesController < ApplicationController
    before_action :authenticate_user!, except: [:show]

    

    def show

        if user_signed_in?
            @profile = Profile.friendly.find(params[:id])
        else
            @profile = Profile.friendly.find(params[:id])
        end

        if user_signed_in?
            profile = Profile.friendly.find(params[:id])
            user = User.where('id =?',@profile.user_id).first
        else
            profile = Profile.friendly.find(params[:id])
            user = User.where('id =?',profile.user_id).first
        end
        
        @uploaded = user.photos.all.count
        
        @likes = Like.where('user_id =?',@profile.user_id).all.count
        

        @views = 0
        user.photos.each do |f|
            @views += f.views
        end

        @most_viewed = user.photos.where('views >=0').order('photos.views DESC').limit(6)
        @most_liked = user.photos.where('likes >=0').order('photos.likes DESC').limit(6)

    end

    def edit

        @profile = current_user.profile

        @user = current_user

    end

    def update


        @profile = current_user.profile
        if @profile.update(profile_params)
            redirect_back fallback_location: profile_path and return
        end

    end

    private


        def profile_params

            params.require(:profile).permit(:hire, :description, :country, :instagram_url, :facebook_url, :my_site, :uploaded_photos, :rating, :profile_name, :user_id, :avatar)

        end
end
    