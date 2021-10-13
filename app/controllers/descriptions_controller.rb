class DescriptionsController < ApplicationController


    def new


    end



    def create

        Description.where('photo_id =?',description_params[:photo_id]).delete_all
        @desc = Description.new(description_params)
        if description_params[:name].blank?
            
        else
          
          if @desc.save
            @description = Description.where('photo_id =?',description_params[:photo_id])
            flash[:desc_added] = ''
            return respond_to do |format|
              format.html { redirect_to @photo }
              format.js
            end
            
          end
          
        end

    end


    def update


    end



    private
     
      # Only allow a list of trusted parameters through.
      def description_params
        params.require(:description).permit(:photo_id,:name, :id, :checked)
      end




end
