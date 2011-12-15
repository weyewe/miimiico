class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      
      t.integer :user_id
      t.integer :project_originator_id

      t.timestamps
    end
  end
end
