#t.string "instagram_url"
#t.string "facebook_url"
#t.string "my_site"
#t.integer "uploaded_photos"
#t.integer "rating"
#t.string "profile_name"
#t.integer "user_id"

class ProfilesController < ApplicationController


    def show

        @profile = current_user.profile
        @uploaded = current_user.photos.all.count
        
        @likes = 0
        current_user.photos.each do |f|
            @likes += f.likes
        end

        @views = 0
        current_user.photos.each do |f|
            @views += f.views
        end

        @most_viewed = current_user.photos.where('views >=0').order('photos.views DESC').limit(6)
        @most_liked = current_user.photos.where('likes >=0').order('photos.likes DESC').limit(6)

    end

    def edit

        @profile = current_user.profile

    end

    def update


        @profile = current_user.profile
        if @profile.update(profile_params)
            redirect_back fallback_location: profile_path and return
        end

    end

    private


        def profile_params

            params.require(:profile).permit(:description, :country, :instagram_url, :facebook_url, :my_site, :uploaded_photos, :rating, :profile_name, :user_id, :avatar)

        end
end
    