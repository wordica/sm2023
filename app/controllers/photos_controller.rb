require "down"
require "fileutils"

class PhotosController < ApplicationController
    before_action :set_photo, only: %i[ show edit update destroy ]
    before_action :authenticate_user!, :except => [:download_photo, :licence, :regulations, :privacy_policy]
  
    def licence



    end

    def privacy_policy


    end

    def regulations

    end


    def index
  
      @photos = current_user.photos.all.order('created_at DESC').paginate(page: params[:page], per_page: 30 )
  
    end
  
    def show

      @tags = Tag.where('photo_id =?',params[:id])
      @tag = Tag.new

      @photo_id = params[:id]

    end

  
    def new

      @photo = current_user.photos.new

    end


    def add_like


      p = params[:id]
      photo = Photo.find(p)
     
      if Like.where(:user_id => current_user.id, :photo_id => p ).present?
      else
        photo.update( :likes => photo.likes + 1 )
        Like.create!(:user_id => current_user.id, :photo_id => p)
      end
      
      flash[:add_like] = ''
      
      return respond_to do |format|
          
          format.js {render 'photos/add_like'}

      end

    end
  
    
    def edit

    end

    def download_photo

      params_h = params[:p_id_data]

      Photo.where('hashed =?',params_h).first.update(:downloads => Photo.where('hashed =?',params_h).first.downloads + 1 )
      
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
        params.require(:photo).permit(:hashed, :image_data,:image, :active, :checked, :user_id, :tags, :views, :likes, :downloads)
      end

  end