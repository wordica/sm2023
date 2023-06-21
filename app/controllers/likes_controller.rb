class LikesController < ApplicationController
   
  




  
    private
     
      # Only allow a list of trusted parameters through.
      def like_params
        params.require(:like).permit(:user_id, :photo_id)
      end

  end