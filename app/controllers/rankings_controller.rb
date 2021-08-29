class RankingsController < ApplicationController

    before_action :authenticate_user!, except: [:index]



    def index
        
        @users = User.where('score >=?',1).order('score DESC').limit(100)
         
    end

    private


        def ranking_params

            params.require(:ranking).permit(:user_id, :views,:downloads, :likes, :score )

        end


end
