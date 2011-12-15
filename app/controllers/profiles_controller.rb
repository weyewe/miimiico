class ProfilesController < ApplicationController
  
  def edit_profile_pic
    @user = current_user
    @profile = current_user.profile
  end
  
  def update
    @profile = Profile.find_by_id( params[:id]) || current_user.profile
    @profile.update_attributes( params[:profile] )




    respond_to do |format|
      format.html { redirect_to profiles_url}
      format.js
    end
  end
  
  def update_profile_pic
    @profile = current_user.profile
    
    if not params[:transloadit].nil?
      @profile.save_profile_pic( params[:transloadit][:results][:resize_comment].first[:url],
        params[:transloadit][:results][:resize_collaborator].first[:url] )
    end
    
  
    
    respond_to do |format|
      format.html { redirect_to edit_profile_pic_url}
      format.js
    end
  end
  
  
  def crop
    @profile = current_user.profile
    
    if not params[:transloadit].nil?
      @profile.save_profile_pic( params[:transloadit][:results][:resize_comment].first[:url],
        params[:transloadit][:results][:resize_collaborator].first[:url] )
    end
    
  
    
    respond_to do |format|
      format.html { redirect_to edit_profile_pic_url}
      format.js
    end
  end
 
  
  def index
    @profile = current_user.profile
  end
  
end
