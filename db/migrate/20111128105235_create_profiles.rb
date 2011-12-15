class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      t.string :name 
      t.text :description 
      
      t.string :profile_pic
      t.string :cropped_profile_pic
      t.boolean :is_cropping , :default => false 
      
      t.integer :user_id
      t.timestamps
    end
  end
end
