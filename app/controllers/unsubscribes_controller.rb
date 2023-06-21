class UnsubscribesController < ApplicationController
    before_action :authenticate_user!, except: [:new,:create]



    def new

        @unsubscribe = Unsubscribe.new
        
    end

    def create

      @unsubscribe = Unsubscribe.new(unsubscribe_params)
      
        if @unsubscribe.freq_ask?

          flash[:unsubscribe_freq] = ''
          redirect_back(fallback_location:"/")
          
        else

          if @unsubscribe.save

            flash[:email_removed] = ''
            redirect_to root_path

          end

        end


    end


    private
    # Only allow a list of trusted parameters through.
    def unsubscribe_params
      params.require(:unsubscribe).permit(:email, :token)
    end    

end