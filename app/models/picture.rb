class Picture < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  acts_as_commentable
  has_many :comment_positions
    
  def get_original
    if self.is_original == true 
      return self
    end
    Picture.find_by_id( self.original_picture_id)
  end

  def uploader
    return self.user
  end

  def get_revisions
    original_picture_id =  0 
    if self.is_original == true 
      original_picture_id = self.id
    else
      original_picture_id = self.original_picture_id 
    end
    
    Picture.find(:all , :conditions => {
      :original_picture_id => original_picture_id
    }, :order => "created_at DESC")
  end
  
  def get_latest_revision
    latest_revision = Picture.find(:first , :conditions => {
      :original_picture_id => self.id
    }, :order => "created_at DESC")
    
    if latest_revision.nil?
      return self
    end
    
    return latest_revision
  end
  
  
  
  def self.project_originals( project_id )
     Picture.find(:all, :conditions => {
       :project_id => project_id, :is_original => true 
     })
  end
  
  def self.extract_uploads(resize_index , resize_show, params, uploads )
    project = Project.find(params[:project_id] )
    user = User.find( params[:user_id] )
    
    if params[:is_original].to_i == ORIGINAL_PICTURE 
      total_project_original = self.project_originals( project.id ).count
      counter = 0 
      uploads.each do |upload|
        original_id = upload[:original_id]
        index_picture_url  = ""
        show_picture_url = ""
        
        resize_index.each do |r_index|
          if r_index[:original_id] == original_id 
            index_picture_url  = r_index[:url]
            break
          end
        end
        
        resize_show.each do |s_index|
          if s_index[:original_id] == original_id 
            show_picture_url  = s_index[:url]
            break
          end
        end
        
        Picture.create(:index_resized_url => index_picture_url , 
                       :show_resized_url => show_picture_url , 
                       :project_id => project.id, 
                       :title => 1 + counter + total_project_original , 
                       :is_original => true ,
                       :user_id => user.id)
        counter =  counter + 1 
      end
    elsif params[:is_original].to_i == REVISION_PICTURE
      original_picture = Picture.find_by_id(params[:original_picture_id])
      index_picture_url = resize_index.first[:url]
      show_picture_url = resize_show.first[:url]
      Picture.create(:index_resized_url => index_picture_url , 
                    :show_resized_url => show_picture_url , 
                    :project_id => project.id , 
                    :title =>  original_picture.title , 
                    :is_original => false ,
                    :user_id => user.id , 
                    :original_picture_id => original_picture.id )
    end
  end
end
