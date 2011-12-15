class HomeController < ApplicationController
  skip_filter :authenticate_user!, :only => [ :index]
  
  def index
  end
  
end
