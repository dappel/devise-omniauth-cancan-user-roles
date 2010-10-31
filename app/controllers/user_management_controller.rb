class UserManagementController < ApplicationController
  
  def index
     @user = User.all   #was @users
     @authentications = Authentication.all

      respond_to do |format|
         format.html # index.html.erb
      end
   end
   
   # POST /users
   # POST /users.xml
   def create
     @user = User.new(params[:user])
     @authentications = Authentication.find(:all, :order => 'user_id') #Gertig

     respond_to do |format|
       if @user.save
         format.html { redirect_to(@user, :notice => 'user was successfully created.') }
         format.xml  { render :xml => @user, :status => :created, :location => @user }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
       end
     end
   end

   # PUT /users/1
   # PUT /users/1.xml
   def update
     @user = User.find(params[:id])
     @authentications = Authentication.find(:all, :order => 'name') #Gertig

     respond_to do |format|
       if @user.update_attributes(params[:user])
         format.html { redirect_to(@user, :notice => 'user was successfully updated.') }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
       end
     end
   end

   # DELETE /users/1
   # DELETE /users/1.xml
   def destroy
     @user = User.find(params[:id])
     @user.destroy

     respond_to do |format|
       format.html { redirect_to(users_url) }
       format.xml  { head :ok }
     end
   end

end
