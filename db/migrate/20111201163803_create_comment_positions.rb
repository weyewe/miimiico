class CreateCommentPositions < ActiveRecord::Migration
  def change
    create_table :comment_positions do |t|
      
      t.integer :comment_id
      t.integer :x_start
      t.integer :y_start
      t.integer :x_end
      t.integer :y_end
      t.integer :picture_id

      t.timestamps
    end
  end
end
