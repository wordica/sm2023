class TagsController < ApplicationController


    #SELECT name, COUNT(*) c FROM table GROUP BY name HAVING c > 1;

    def create
        
       
        @tag = Tag.new(tags_params)
        if tags_params[:name].blank?
            
        else
          
          if @tag.save
            @tags = Tag.where('photo_id =?',tags_params[:photo_id])
            flash[:tag_added] = ''
            return respond_to do |format|
              format.html { redirect_to @photo }
              format.js
            end
            
          end
          
        end
        
    end
     
     
     
      def tag_delete
        
        @tag = Tag.where('id =?',params[:to_delete]).first
        @photo_id = @tag.photo_id
        @tag.destroy
        @tags = Tag.where('photo_id =?',@photo_id)

        
        respond_to do |format|
          format.js {render 'tags/tag_delete'}
        end
        
      end
     





      private

      # Only allow a list of trusted parameters through.
      def tags_params
        params.require(:tag).permit(:id, :counter, :user_id, :photo_id, :name)
      end

end
