class Photo < ActiveRecord::Base
    
    
    include ImageUploader::Attachment(:image)

    belongs_to :user
    has_many :tags
    accepts_nested_attributes_for :tags

end
