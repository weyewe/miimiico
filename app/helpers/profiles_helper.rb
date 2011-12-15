module ProfilesHelper

  PROFILE_DEFAULT = {
    :fake_name => "Your name here", 
    :fake_description => %q{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae tortor sapien, nec volutpat felis. Maecenas placerat, dui at pulvinar eleifend, est massa accumsan nibh, in aliquet est purus sed lectus. Proin ac dolor eu dui fermentum pulvinar et id dolor. Aliquam lacinia, risus id commodo condimentum, nibh purus dignissim magna, at hendrerit metus arcu quis felis. Nulla tincidunt commodo placerat. Donec tincidunt suscipit erat quis posuere. In quis tellus mauris. Duis quis ligula id mauris lacinia posuere. Maecenas auctor, nisl eu tristique feugiat, nulla nisl mattis ligula, vel posuere purus lectus vel nunc.
		<br /><br />
		Proin cursus placerat sodales. Cras vitae lectus ut sem dignissim pretium ut eu diam. Pellentesque et tellus libero, eget venenatis augue. Integer at euismod velit. Integer iaculis vulputate est, quis semper dolor ultricies eu.
    }
  }
  
  
  def get_content( stored_name , selection)
    if stored_name.nil? || stored_name.length == 0 
      return PROFILE_DEFAULT[selection].html_safe
    end
    return stored_name 
  end
end
