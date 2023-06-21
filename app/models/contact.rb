class Contact < ApplicationRecord

	
  

    validates :subject, :presence => true, :length => { :within => 3..255 }
    validates :body, :presence => true, :length => { :within => 3..3000 }
  
    
  end
  