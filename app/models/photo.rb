class Photo < ActiveRecord::Base
    
    belongs_to :user

    scope :checked, -> { where(:checked => true) }
  	scope :unchecked, -> { where(:checked => false) }


    include ImageUploader::Attachment(:image)

    belongs_to :user
    has_many :tags, :dependent => :destroy
    accepts_nested_attributes_for :tags

    has_one :description, :dependent => :destroy

    after_create :add_hash

    
    def get_related_photos

      photo = self
      this_photo_tags = []
      if Tag.where('photo_id =?',photo.id).length > 0

        Tag.where('photo_id =?',photo.id).each do |f|

          this_photo_tags.push(f.name)

        end

      end
      
      related_photos_by = []

      if Tag.where('photo_id =?',photo.id).length > 0

        related_photos_by = Photo.includes(:tags).where('tags.name IN (?)',this_photo_tags).references(:tags).pluck('tags.name')

      end

      duplicates = this_photo_tags + related_photos_by

      dupli_uniq = duplicates.select{|item| duplicates.count(item) > 1}.uniq
     
      photos_ids = []

      if dupli_uniq.length >= 4
        
        dupli_uniq.each_with_index do |_tag,index|

          photos_ids.push(Photo.includes(:tags).where('tags.name =?',_tag).references(:tags).pluck(:id))

          if index == dupli_uniq.size - 1
            photos_ids = photos_ids.flatten
            photos_ids = photos_ids.find_all { |e| photos_ids.count(e) > 2 }
            photos_ids = photos_ids.uniq
            
          end

        end
        #duplicates_4 = duplicates_4.flatten
        #duplicates_4 = duplicates_4.uniq

        #Rails.logger.fatal "dupka7 #{photos_ids}"
        #Photo.includes(:tags).where('tags.name IN (?)',duplicates).group('photos.id').having('count (*) =?',duplicates.length).references(:tags).limit(15).each do |f|
        #Photo.includes(:tags).where('tags.name IN (?)',duplicates).references(:tags).limit(15).each do |f|
         
            #returned_array.push(f.id)
          
        #end

         #Photo.includes(:tags).where('tags.name IN (?)',duplicates).references(:tags).limit(15).each do |f|
          
          #returned_array.push(f.id)

        #end

      end
      
      #here we set how many index will be returned
      return photos_ids

    end


    

    def approve!
    
      self.update(:checked => true)
         #Informations.create!(:user_id => self.user.id, :sender_id => 1, :content => I18n.t("vocabulary.accepted_av"), :subject_h => '' )
  
    end


    def reject!
    
      self.destroy
         #Informations.create!(:user_id => self.user.id, :sender_id => 1, :content => I18n.t("vocabulary.accepted_av"), :subject_h => '' )
  
    end
    


    def add_hash

        len = 18
        p_fake_id = SecureRandom.alphanumeric(@len)
        self.update(:hashed => p_fake_id)

    end

end
