class PagesController < ApplicationController
    skip_before_action :authenticate_user!

    
    def home

        @search = Search.new
        @photos = Photo.all.order('created_at DESC').paginate(page: params[:page], per_page: 12 )
        @a = Tag.find_by_sql('SELECT name, COUNT(*) c FROM tags GROUP BY name HAVING c > 1 ORDER BY c DESC')
        
        @tags = []
        @a.take(27).each do |f|

            @tags.push(f.name)

        end
        

    end

    def home_logged_in

        @search = Search.new
        @photos = Photo.all.order('created_at DESC').paginate(page: params[:page], per_page: 12 )
        
        @a = Tag.find_by_sql('SELECT name, COUNT(*) c FROM tags GROUP BY name HAVING c > 1 ORDER BY c DESC')
        
        @tags = []
        @a.take(27).each do |f|

            @tags.push(f.name)

        end

    end



end
