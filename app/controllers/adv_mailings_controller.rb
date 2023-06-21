class AdvMailingsController < ApplicationController
  


private
    # Only allow a list of trusted parameters through.
    def advmailing_params
      params.require(:advmailing).permit(:email, :id, :token)
    end

end
