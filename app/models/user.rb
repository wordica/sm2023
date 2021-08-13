class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  validates :username, :presence => true, :length => { :within => 4..16 }, :uniqueness => { :case_sensitive => false },
                   :format => { :with => /\A[\w]+\z/i }
                   
  validates :email, :presence => true, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            :uniqueness => { :case_sensitive => false }

  has_many :photos, :dependent => :destroy

  has_one :profile, :dependent => :destroy


end
