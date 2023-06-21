class ContactsController < ApplicationController
    skip_before_action :authenticate_user!
  
    def new
  
      @contact = Contact.new
  
    end
  
    def create
  
      @contact = Contact.new
  
      @contact.user_agent = request.env['HTTP_USER_AGENT']
  
      @contact.email = params[:contact][:email]
      @contact.body = params[:contact][:body]
      @contact.subject = params[:contact][:subject]
  
      if @contact.save
  
        ApplicationMailer.new_contact(@contact).deliver
        redirect_back fallback_location: new_contact_path and return  #, :notice => 'Wiadomosc wyslano'
  
      else
        
        redirect_back fallback_location: new_contact_path and return
  
      end
  
    end
  
  
    private
    # Only allow a list of trusted parameters through.
      def contact_params
        params.require(:contact).permit(:body, :email, :subject, :name)
      end
  
  
  end