class PhotosController < ApplicationController
    before_action :set_photo, only: %i[ show edit update destroy ]
    before_action :authenticate_user!
  
    
    def index
  
      @photos = current_user.photos.all.order('created_at DESC')
  
    end
  
    def show

      @tags = Tag.where('photo_id =?',params[:id])
      @tag = Tag.new

      @photo_id = params[:id]

    end
  
    def new

      @photo = current_user.photos.new

    end
  
    
    def edit

    end
  
    
    def create

      @photo = current_user.photos.new(photo_params)
      @photo.user_id = current_user.id
      @photo.image_derivatives!

      respond_to do |format|

        if @photo.save
          format.html { redirect_to @photo }
         
        else

          format.html { render :new, status: :unprocessable_entity }

        end
      end
  
    end
  
   
    def update
  
      @photo = current_user.photos.new(photo_params)
      @photo.user_id = current_user.id
      @photo.image_derivatives!
      
      respond_to do |format|

        if @photo.update(photo_params)

          format.html { redirect_to @photo }
          
        else

          format.html { render :edit, status: :unprocessable_entity }
        
        end

      end

    end
  
    #
    def destroy
  
      @photo.destroy

      redirect_back fallback_location: photos_path and return
     
    end
  
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_photo
        @photo = Photo.find(params[:id])
      end
      # Only allow a list of trusted parameters through.
      def photo_params
        params.require(:photo).permit(:image_data, :image, :active, :checked, :user_id, :tags)
      end

  end