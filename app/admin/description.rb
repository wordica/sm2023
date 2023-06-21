ActiveAdmin.register Description, :as => 'Description' do
    
    menu :priority => 3

    permit_params :name, :photo_id, :id, :created_at, :updated_at

    
    filter :photo_id


    scope :all
    scope :checked
    scope :unchecked, :default => true

    controller do

       
        def new
            @description = Description.new(permitted_params)
            render 'admin/description/new', :layout =>"active_admin"
        end
        
        def create
          @description = Description.new(permitted_params[:description])
          @description.save!
          redirect_back fallback_location: collection_path
        end

    end

    index do
    
        selectable_column
        column :photo_id
        column :photo_img do |p|

            image_tag Photo.where('id =?',p.photo_id).first.image_url(:thumb)

        end

        column :name

        column :actions do |u|

            links = ''.html_safe
            links << link_to('edit', [:edit, :admin, u], :class => "member_link")
            links << link_to('delete', [:admin, u], :class => "member_link", :method => :delete, data: { confirm: 'are you sure?'})
            #links
        end

    end

    batch_action :destroy, data: { confirm: 'are you sure?'}, :plural_model => "descriptions" do |selection|
        Description.find(selection).each { |a| a.reject! }
        redirect_to collection_path, :notice => "Description destroyed"
      end

    batch_action :approve do |selection|
        Description.find(selection).each { |a| a.approve! }
        redirect_to collection_path, :notice => "Description approved"
    end

    

end