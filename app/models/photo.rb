class Photo < ActiveRecord::Base
    
    belongs_to :user

    scope :checked, -> { where(:checked => true) }
  	scope :unchecked, -> { where(:checked => false) }


    include ImageUploader::Attachment(:image)

    belongs_to :user
    has_many :tags, :dependent => :destroy
    accepts_nested_attributes_for :tags

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

      duplicates = this_photo_tags & related_photos_by
     
      returned_array = []
      if duplicates.length > 1

         Photo.includes(:tags).where('tags.name IN (?)',duplicates).references(:tags).each do |f|
          
          returned_array.push(f.id)

        end

      end
      
      #here we set how many index will be returned
      return returned_array

    end

    

    def approve!
    
      self.update(:checked => true)
         #Informations.create!(:user_id => self.user.id, :sender_id => 1, :content => I18n.t("vocabulary.accepted_av"), :subject_h => '' )
  
    end
    


    def add_hash

        len = 18
        p_fake_id = SecureRandom.alphanumeric(@len)
        self.update(:hashed => p_fake_id)

    end

end
