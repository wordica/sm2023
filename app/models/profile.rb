class Profile < ApplicationRecord

    extend FriendlyId
  	friendly_id :profile_name, use: :slugged

    has_one_attached :avatar
    belongs_to :user

    def avatar_
       
        avatar.variant(resize_to_fill: [150, 150]).processed 
        

    end

end
