class UsersController < ApplicationController

    before_action :authenticate_user!


    def hire_form


    end



    private
        # Only allow a list of trusted parameters through.
        def user_params
          params.require(:user).permit(:blocked, 
                                       :current_sign_in_at,
                                       :last_sign_in_at,
                                       :current_sign_in_ip,
                                       :last_sign_in_ip,
                                       :gender,
                                       :password,
                                       :password_confirmation,
                                       :email,
                                       :terms, 
                                       :personal_data, 
                                       :marketing, 
                                       :marketing_second,
                                       :score
                                      )
        end
    
    
    end
    