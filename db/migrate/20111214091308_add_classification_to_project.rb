class AddClassificationToProject < ActiveRecord::Migration
  def change
    add_column :projects, :is_private , :boolean, :default => false 
  end
end
