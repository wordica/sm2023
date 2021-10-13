class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable



  validates :username, :presence => true, :length => { :within => 4..16 }, :uniqueness => { :case_sensitive => false },
                   :format => { :with => /\A[\w]+\z/i }
                   
  validates :email, :presence => true, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            :uniqueness => { :case_sensitive => false }

  has_many :photos, :dependent => :destroy

  has_one :profile, :dependent => :destroy

  has_one :ranking, :dependent => :destroy

  has_many :messages, :dependent => :destroy

  after_create :add_profile_name
  
  before_create :init_profile

  before_create :put_in_ranking

  

  def add_profile_name

    if self.profile.profile_name.blank?

       self.profile.profile_name = self.username
       
    end
    

  end


  def block_ip
    
    ip = self.current_sign_in_ip
    email = self.email
    username = self.username
    ip_banned = UserBanned.new(:ip => ip, :email => email, :username => username)
    ip_banned.save

    self.blocked = true
    self.save

  end


  private

  def put_in_ranking

    build_ranking

  end

  def init_profile

    build_profile

  end

end
