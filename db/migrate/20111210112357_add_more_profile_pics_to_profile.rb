class AddMoreProfilePicsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :collaboration_image, :string
    add_column :profiles, :comment_image, :string
    
  end
end
