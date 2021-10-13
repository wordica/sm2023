  class SearchesController < ApplicationController
    skip_before_action :authenticate_user!



    def new 

      @search = Search.new

      if params[:author].present?
        profile = Profile.where('profile_name =?',params[:author]).first
        user_id = profile.user_id
        @photos = Photo.where('checked =? and user_id =?',true, user_id).order('created_at DESC').paginate(page: params[:page], per_page: 10 )
      end
      


      # TAGS DISPLAY
      @a = Tag.find_by_sql('SELECT name, COUNT(*) c FROM tags GROUP BY name HAVING c > 1 ORDER BY c DESC')
      @tags = []
      @a.take(27).each do |f| @tags.push(f.name) end

    end


    def searches_results

      # TAGS DISPLAY
      @a = Tag.find_by_sql('SELECT name, COUNT(*) c FROM tags GROUP BY name HAVING c > 1 ORDER BY c DESC')
      @tags = []
      @a.take(27).each do |f| @tags.push(f.name) end
      
      keywords = ''
      
      if params[:search].nil?

        param = params[:keyword]

      else

        param = params[:search][:keyword]

      end
      
      if !param.empty? && param.include?(' ')

        keywords = param.parameterize(separator: ',').split(',')

      elsif param.empty?

        keywords = 'all'.split(',')

      else 

        keywords = param.split(',')
        
      end

      photos_ids_from_tags = []
      
      Tag.all.each do |f|

        #rescue check and add
        keywords.each do |k|

          if f.name.include? k
            
            photos_ids_from_tags.push(f.photo_id)

          end

        end
      
      end

      photos_ids_from_tags = photos_ids_from_tags.uniq

      if keywords[0] == 'all'

        @photos = Photo.where('checked =?',true).order('created_at DESC').paginate(page: params[:page], per_page: 10)
      
      else

        @photos = Photo.where('checked =? and id IN (?)',true, photos_ids_from_tags).order('created_at DESC').paginate(page: params[:page], per_page: 10)

      end
      

    end


    def most_popular_free_photos

      #srednia likow likes = ?

      # TAGS DISPLAY
      @a = Tag.find_by_sql('SELECT name, COUNT(*) c FROM tags GROUP BY name HAVING c > 1 ORDER BY c DESC')
      @tags = []
      @a.take(27).each do |f| @tags.push(f.name) end

      @photos = Photo.where('checked =? and likes >=?',true, 0).all.order('downloads DESC').paginate(page: params[:page], per_page: 22)

    end







     # Only allow a list of trusted parameters through.
     def search_params
        params.require(:search).permit(:author, :keyword)
      end


end
