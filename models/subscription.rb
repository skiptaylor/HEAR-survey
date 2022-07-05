class Subscription
	include DataMapper::Resource

	timestamps :at, :on
	property   :deleted_at, ParanoidDateTime
	property 	 :id, 				Serial

  property  :sub_code,    String
  
  property :used,         Boolean, :default => false
        
end 