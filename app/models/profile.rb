class Profile < ApplicationRecord

    extend FriendlyId
  	friendly_id :profile_name, use: :slugged

    has_one_attached :avatar
    belongs_to :user

    after_create :add_profile_name

    def avatar_show
       
        self.avatar.variant(resize_to_fill: [150, 150]).processed 

    end


    def add_profile_name

      self.profile_name = self.user.username
      self.save!

    end

end
