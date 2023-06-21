class MessagesController < ApplicationController
    
    before_action :authenticate_user!, except: [:new, :create]

    def index

      @messages = Message.where('user_id =?',current_user.id).all.order('created_at DESC').paginate(page: params[:page], per_page: 10 )

    end

    def new

      @message_new = Message.new

    end


    def create

      @message_new = Message.new(message_params)

      if @message_new.save

        flash[:mgs_send] = ''
        redirect_back fallback_location: new_message_path and return 

      end

    end


    def destroy

      Message.destroy(params[:id])
      redirect_back fallback_location: messages_path and return 

    end



    private

      def message_params

        params.require(:message).permit(:email, :user_id, :subject, :content)

      end


end
