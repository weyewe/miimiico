module PicturesHelper
  
  def get_reply_count( total_reply_count )
    if total_reply_count == 0 || total_reply_count == 1 
      return "#{total_reply_count} Reply"
    else
      return "#{total_reply_count} Replies"
    end
  end
end
