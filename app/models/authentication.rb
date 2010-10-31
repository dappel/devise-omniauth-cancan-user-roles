class Authentication < ActiveRecord::Base
  
  belongs_to :user
  validates_uniqueness_of :uid 
  #Gertig attr_accessible :user_id, :provider, :uid
end
