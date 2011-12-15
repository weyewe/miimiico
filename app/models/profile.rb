class Profile < ActiveRecord::Base
  belongs_to :user
  
  def save_profile_pic( comment_pic, collaborator_pic)
    self.profile_pic = collaborator_pic
    self.comment_image = comment_pic 
    self.save
  end


end
