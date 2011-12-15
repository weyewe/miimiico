class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :original_url
      t.string :show_resized_url
      t.string :index_resized_url 
      
      t.string :title
      
      t.boolean :is_original , :default => true

      t.integer :original_picture_id, :default => nil
      t.integer :project_id
      
      t.integer :user_id

      t.timestamps
    end
  end
end
