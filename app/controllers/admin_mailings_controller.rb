class AdminMailingsController < ApplicationController





private
    # Only allow a list of trusted parameters through.
    def adminmailing_params
      params.require(:adminmailing).permit(:id, :sender_1, :subject_1, :sent, :filters, :created_at, :updated_at, :authentication_token, :name, :adv_token)
    end

end
