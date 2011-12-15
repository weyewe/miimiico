class ApplicationController < ActionController::Base
  include Transloadit::Rails::ParamsDecoder
  protect_from_forgery
  before_filter :authenticate_user!
  
  
  def after_sign_in_path_for(resource)
    get_project( params )

    if not @project.nil?
      user_project_url( @project.project_originator_id, @project)
    else
      root_url 
    end
  end
  
  protected
  
  def get_project( params )
    if not params[:project_id].nil?
      @project = Project.find( params[:project_id] )
    end
  end
  

  def protect_project_from_uninvited_user
    if not @project.can_be_viewed_by?( current_user ) 
      redirect_to root_url
    end
  end
  

   
end
