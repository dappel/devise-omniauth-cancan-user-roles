class RegistrationsController < Devise::RegistrationsController #ApplicationController
  
  #Overide some of Devise registration controller functionality
  #Inherit straight from Devise's RegistrationsController
  
    def create
      super
      session[:omniauthhash] = nil unless @user.new_record?
    end

    private

    #Devise RegistrationsController has a method called build_resource
    #This builds the User model in the new and create actions inside the controller
    def build_resource(*args)
      super
      if session[:omniauthhash]
        @user.apply_omniauth(session[:omniauthhash]) #apply_omniauth is the method in User model 
        @user.valid?
      end
    end
    
end
