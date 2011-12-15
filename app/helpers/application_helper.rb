module ApplicationHelper
  DEFAULT_TITLE = "Tools for graphic worker"
  
  def extract_page_title
    return @title if not @title.nil? 
    return DEFAULT_TITLE  
  end
  
  def get_profile_pic_url(profile_pic)
    
    if profile_pic.nil? || profile_pic.length == 0 
      return "y-u-not-upload-profile-pic.jpg"
    end
    
    return profile_pic 
  end
  
  def get_comment_pic_url( comment_image )
    if comment_image.nil? || comment_image.length == 0 
      return "y-u-not-upload-profile-pic-comment.jpg"
    end
    
    return comment_image 
    
  end
  
  
  
  
  def print_revision_count( pic ) 
    revision_count  =  pic.get_revisions.count
    
    if revision_count == 0 || revision_count == 1 
      return "#{revision_count} revision"
    end
    
    return "#{revision_count} revisions"
  end
  
  def get_subnav_status(params, section)
    # home, private_projects, public_projects, setting, 
    if section == "images"
      if selecting_images_tab?(params)
        return "selected"
      end
    end
    
    if section == "collaborators"
      if selecting_project_collaborators_tab?(params)
        return "selected"
      end
    end
   
    
    
  end
  
  
  def get_primary_nav_status(params, section)
    # home, private_projects, public_projects, setting, 
    if section == "home"
      if selecting_home_tab?(params)
        return "current"
      end
    end
    
    if section == "private_projects"
      if selecting_private_projects_tab?(params)
        return "current"
      end
    end
    
    if section == "setting"
      if selecting_setting_tab?(params)
        return "current"
      end
    end
    
    
  end
  
  def get_profile_nav_status(params, section)
    if section == 'username'
      if selecting_username_tab?(params)
        return "selected"
      end
    end
    
    if section == 'password'
      if selecting_password_tab?(params)
        return "selected"
      end
    end
    
    if section == 'profile'
      if selecting_profile_tab?(params)
        return "selected"
      end
    end
    
    if section == 'profile_pic'
      if selecting_profile_pic_tab?(params)
        return "selected"
      end
    end
  end
  
  protected
  
  
  def selecting_images_tab?(params)
    if params[:controller] == "projects" && params[:action] != "show_collaborators"
      return true 
    end
    return false 
  end
  
  def selecting_project_collaborators_tab?(params)
    if params[:controller] == "projects" && params[:action] == "show_collaborators"
      return true 
    end
    return false 
  end
  
  
  
  def selecting_setting_tab?(params)
    if ( params[:controller] == "profiles" || params[:controller] == "passwords")
      return true
    end
    
    return false
  end
  
  
  def selecting_private_projects_tab?(params)
    if ( params[:controller] == "projects" || params[:controller] == "pictures")
      return true
    end
    
    return false
  end
  
  def selecting_home_tab?(params)
    if params[:controller] == "home" && params[:action] == "index"
      return true
    end
    
    return false
  end
  
  
  def selecting_username_tab?(params)
    if params[:controller] == "passwords" && params[:action] == "edit_username"
      return true
    end
    
    return false
  end
  
  def selecting_password_tab?(params)
    if params[:controller] == "passwords" && params[:action] == "edit_credential"
      return true
    end
    
    return false
  end
  
  def selecting_profile_tab?(params)
    if params[:controller] == "profiles" && params[:action] == "index"
      return true
    end
    
    return false
  end
  
  def selecting_profile_pic_tab?(params)
    if params[:controller] == "profiles" && params[:action] == "edit_profile_pic"
      return true
    end
    
    return false
  end
  
  
end
