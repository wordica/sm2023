class AdminMailingSendsController < ApplicationController

 
  private
    # Only allow a list of trusted parameters through.
    def adminmailingsend_params
      params.require(:adminmailingsend).permit(
                                                :user_id, 
                                                :name, 
                                                :email, 
                                                :authentication_token, 
                                                :term_gender_id, 
                                                :sender_id, 
                                                :sender_email, 
                                                :subject,
                                                :template
                                               )
    end

end
