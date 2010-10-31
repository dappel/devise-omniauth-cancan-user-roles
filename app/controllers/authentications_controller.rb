class AuthenticationsController < ApplicationController
  load_and_authorize_resource
  #This was generated with Ryanb's nifty-generators
  # rails g nifty:scaffold authentication user_id:integer provider:string uid:string index create destroy
  
  def index
    @authentications = current_user.authentications if current_user #Authentication.all
  end
  
  def create

    #render :text => request.env["omniauth.auth"].to_yaml #Just used to show the provider details.
    omniauthhash = request.env["omniauth.auth"]
    #current_user.authentications.find_or_create_by_provider_and_uid(omniauthhash['provider'], omniauthhash['uid'])
    #flash[:notice] = "Authentication successful."
    #redirect_to authentications_url
    
     authentication = Authentication.find_by_provider_and_uid(omniauthhash['provider'], omniauthhash['uid'])
     puts "Authentication Time"
     puts authentication.user_id if authentication
     puts current_user.id if current_user
     
     
        if authentication #Authentication record exists and Current_User exists
          if current_user && current_user.id != authentication.user_id #Checks if Authentication record already exists
            flash[:error] = "This LinkedIn connection already exists."
            redirect_to root_url
          elsif user_signed_in?
            flash[:notice] = "You have already added Linkedin!"
            redirect_to root_url
          else
            #This signs a User in if they are taken to /auth/linked_in while no user is signed in
            flash[:notice] = "Signed in successfully."
            sign_in_and_redirect(:user, authentication.user) #Omniauth method  #Gertig, root_url)
          end
        elsif current_user #Current_User exists
          current_user.authentications.create!(:provider => omniauthhash['provider'], :uid => omniauthhash['uid'])
          
          current_user.update_attribute(:image_url, omniauthhash['user_info']['image'])
          flash[:notice] = "Connected to LinkedIn successfully."
          redirect_to root_url

          #redirect_to root_url #Gertig, authentications_url
        else #New User
          puts "New User"
          user = User.new
          user.apply_omniauth(omniauthhash) #Found in the user model
          if user.save
            flash[:notice] = "Signed in successfully."
            sign_in_and_redirect(:user, user) #Omniauth method
          else
            session[:omniauthhash] = omniauthhash.except('extra') #This saves the hash to a session cookie without the 'extra' piece of the API return
            redirect_to new_user_registration_url
          end
        end
    
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id]) #Authentication.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
