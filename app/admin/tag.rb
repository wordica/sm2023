ActiveAdmin.register Tag, :as => 'Tags' do
    
    menu :priority => 4
    
    permit_params :name, :photo_id, :id, :created_at, :updated_at

    filter :photo_id
    

    controller do

       
        def new
            @tag = Tag.new(permitted_params)
            render 'admin/tags/new', :layout =>"active_admin"
        end
        
        def create
          @tag = Tag.new(permitted_params[:tag])
          @tag.save!
          redirect_back fallback_location: collection_path
        end

    end

    index do

        selectable_column

        column :photo_id
        column :photo do |f|

            image_tag Photo.where('id =?',f.photo_id).first.image_url(:thumb)

        end

        column :name

        column :actions do |u|

            links = ''.html_safe
            links << link_to('edytuj', [:edit, :admin, u], :class => "member_link")
            links
    
        end

    end

    

end