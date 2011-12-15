require 'valid_email'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   extend FriendlyId
   friendly_id :username, :use => :slugged


   include ActiveModel::Validations

   # validates :name, :presence => true, :length => { :maximum => 100 }
   validates :email, :presence => true, :email => true

     
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :slug

  after_create :create_profile, :add_default_username
  
  
  has_many :participations
  has_many :projects, :through => :participations
  has_many :pictures
  has_one :profile
  
  def send_mail_play
    UserMailer.registration_confirmation(self).deliver  
  end
  
  
  def self.send_invitation_email( project, email , invitation_text , inviting_user )
    new_password =  '' 
    invited_user = User.find_by_email( email ) 
    if  invited_user.nil?
      new_password = UUIDTools::UUID.timestamp_create.to_s[0..7]
      invited_user = User.new(:email => email, :password => new_password,
                        :password_confirmation => new_password)
                        
      if invited_user.valid? 
        invited_user.save 
      else
        return nil
      end
    end 
      
      
    UserMailer.project_invitation( invited_user , inviting_user,
      invitation_text, project , new_password ).deliver
      
    return invited_user
    
  end
  
  protected
  
  def add_default_username
    self.username = self.id
    self.save
  end
  
  def create_profile
    Profile.create( :user_id => self.id )
  end
end
