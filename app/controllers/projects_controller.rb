class ProjectsController < ApplicationController
  def index
    @project_originator = User.find(params[:user_id])
    @new_project = Project.new
    @projects = @project_originator.projects
  end
  
  def create
    @project_originator = User.find( params[:user_id] )
    @project = Project.new( params[:project] )
    @project.project_originator_id = @project_originator.id 
    @project.save
    
    redirect_to user_project_url( @project.project_originator_id, @project.id)
  end
  
  def show
    
    @project_originator = User.find( params[:user_id] )
    if @project_originator.nil?
      puts "The project originator is nil"
    else
      puts @project_originator
    end
    @project = Project.find( params[:id] )
    
    protect_project_from_uninvited_user 
  
  end
  
  def show_collaborators
    @project = Project.find( params[:project_id])
    @profile = @project.project_originator.profile
    
    protect_project_from_uninvited_user
  end
  
  def add_collaborator
    
 
    @project = Project.find( params[:project_id])
    @project.add_collaborators_from_user_hash( params[:user] , params[:message])
    
    redirect_to user_project_url( @project.project_originator_id, @project)
  end
  
  
 
end
