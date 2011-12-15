class PicturesController < ApplicationController
  
  def create
    Picture.extract_uploads( params[:transloadit][:results][:resize_index], 
      params[:transloadit][:results][:resize_show], params, params[:transloadit][:uploads] )
      
    redirect_to user_project_url(params[:project_originator_id] , params[:project_id]  )
  end
  
  def create_revision
    @picture = Picture.extract_uploads( params[:transloadit][:results][:resize_index], 
      params[:transloadit][:results][:resize_show], params, params[:transloadit][:uploads] )
      
    redirect_to project_picture_url( @picture.project, @picture)
  end
  
  def index
  end
  
  
  
  def show
    @project  = Project.find(params[:project_id])
    @project_originator = @project.project_originator
    @picture = Picture.find_by_id( params[:id] )
    @profile = @picture.user.profile
    @original_picture = @picture.get_original
    @original_comments = @picture.root_comments.order("created_at  ASC")
    @revisions = @picture.get_revisions
    
    protect_project_from_uninvited_user
  end
  
  def add_comment
    @picture = Picture.find(params[:picture_id])
    @user_who_commented = current_user
    @comment = Comment.build_from( @picture, @user_who_commented.id, params[:comment_value] )
    puts @comment
    @comment.save
    
    @create_root_comment = true 
    @parent_comment_id = params[:parent_comment_id] 
    
    if not params[:parent_comment_id].nil? and params[:parent_comment_id].length != 0 
      @comment.move_to_child_of( Comment.find_by_id( params[:parent_comment_id] ) )
      @create_root_comment = false 
    end
    
    
    respond_to do |format|
      format.html { redirect_to project_picture_url( @picture.project, @picture)}
      format.js
    end
    
    
  end
  
  def add_positional_comment
    @picture = Picture.find(params[:picture_id])
    @user_who_commented = current_user
    @root_comment = Comment.build_from( @picture, @user_who_commented.id, params[:comment_value] )
    @root_comment.save
    
    @root_comment.create_comment_position( params[:x1], params[:y1], params[:x2], params[:y2] ,  @picture)
    
    
    respond_to do |format|
      format.html {  redirect_to project_picture_url( @picture.project, @picture)}
      format.js
    end
    
    
    
  end
end
