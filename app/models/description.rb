class Description < ApplicationRecord

    belongs_to :photo


    scope :checked, -> { where(:checked => true) }
  	scope :unchecked, -> { where(:checked => false) }

    validates :name, :allow_blank => true, :length => { :within => 2..3000 }

    before_save :reset_approved


    def approve!
    
        self.update(:checked => true)
       
    end

    def reject!
    
        self.update(:checked => true, :name => 'No approved photo description')
       
    end





private

    def reset_approved
        self.checked = false if self.name_changed?
        true
    end

    
end
