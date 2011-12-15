class CommentPosition < ActiveRecord::Base
  belongs_to :comment
  belongs_to :picture
end
