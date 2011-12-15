class Project < ActiveRecord::Base
  has_many :participations
  has_many :users , :through => :participations
  
  after_create :add_default_participant
  
  has_many :pictures
  

  extend FriendlyId
  friendly_id :title, :use => :slugged


  def can_be_viewed_by?( collaborator ) 
   ( self.has_included(collaborator)  ) ||  ( not self.is_private?  ) 
  end

  def add_collaborators_from_user_hash( user_hash , invitation_text )
    emails = user_hash[:email]
    emails = emails.gsub(/ /,'')
    
    emails.split(";").each do |email|
      new_collaborator = User.send_invitation_email( self, email , invitation_text , self.project_originator )
      
      if not new_collaborator.nil?  && ( not self.has_included( new_collaborator ) )
        self.add_collaborator( new_collaborator.id )
      end
    end
  end
  
  def has_included( new_collaborator) 
    self.collaborators_user_id.include?( new_collaborator.id )
  end
  
  def collaborators_user_id
    self.participations.collect do |x|
      x.user_id
    end
  end
  
  def get_participations_ordered
    self.participations.order("created_at ASC")
  end
  
  
  def project_originator
    User.find_by_id(self.project_originator_id)
  end
  
  def original_pictures
    self.pictures.where(:is_original => true)
  end
  
  def index_pictures
    original_pictures.collect do |pic|
      pic.latest_revision
    end
  end
  
  
  def project_list_image
    if self.pictures.count > 0 
      self.pictures.find(:first, :order => "created_at DESC").index_resized_url
    end
  end
  
 
  
  protected
  
  def add_collaborator( collaborator_id )
    self.participations.create :user_id => collaborator_id
  end


  def add_default_participant
    self.participations.create :user_id => self.project_originator_id
  end
  
end
