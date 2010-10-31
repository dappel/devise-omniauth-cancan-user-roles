class Ability
  include CanCan::Ability

  def initialize(user)
   user ||= User.new # guest user
    
   if user.role == "admin"
          can :manage, :all
   else
     #can :read, :all #An example of using this would be to allow guest users to read a blog entry but not edit it
    
     can [:create, :upate], Authentication
    
     if user.role == "notadmin"
        can [:edit, :update], User do |u|
          u.try(:id) == user.id #This ensures that a user with role "notadmin" can only edit their own profile
        end
     end
    
   end
   #end
end
