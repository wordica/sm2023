class UserbannedsController < ApplicationController





	private
   
    # Only allow a list of trusted parameters through.

    def userbanned_params

      params.require(:userbanned).permit(:ip, :username, :email)

    end
end