ActiveAdmin.register Photo, :as => 'photo' do
    before_filter { @skip_sidebar = true }
    
    menu :priority => 2
  
    scope :all
    scope :checked
    scope :unchecked, :default => true
  
  
  
    controller do
      def scoped_collection
        Photo.includes(:user)
      end
    end
    
    index do
      
      selectable_column

      column :user
      column :id 
      column :image_data do |i|
  
        link_to image_tag(i.image_url(:thumb)), i.image_url(:fancybox)
  
      end
      column :dimensions do |f|

        MiniMagick::Image.open('http://localhost:3000' + f.image_url).dimensions

      end

      column :size do |f|

        MiniMagick::Image.open('http://localhost:3000' + f.image_url).human_size

      end

      
      column :checked
      
      actions
  
    end
    
    batch_action :approve do |selection|
      Photo.find(selection).each { |a| a.approve! }
      redirect_to collection_path, :notice => "Images approved"
    end
    
    batch_action :destroy, data: { confirm: 'na pewno?'}, :plural_model => "photos" do |selection|
      Photo.find(selection).each { |a| a.reject! }
      redirect_to collection_path, :notice => "Images destroyed"
    end
  
  end