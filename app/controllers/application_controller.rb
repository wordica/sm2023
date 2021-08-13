require "application_responder"
require 'net/https'

class ApplicationController < ActionController::Base
    include Pagy::Backend
    
    self.responder = ApplicationResponder
    respond_to :html


    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    before_action :set_locale
    layout :layout_by_resource


    def set_locale
        I18n.default_locale
     end



   protected

     def configure_permitted_parameters
   
       devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :gender, :terms, :personal_data])
       devise_parameter_sanitizer.permit(:account_update)
       
     end


  private
  def layout_by_resource
    
    if user_signed_in?
      'application'
    else
      'home'
    end
    
  end


  protected

  def json_request?
    request.format.json?
  end


end
