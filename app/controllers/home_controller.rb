class HomeController < ApplicationController
  
  #Devise Authentication
  before_filter :authenticate_user!, :except => [:index]
  
  def index
    
  end

end
