class User
	include DataMapper::Resource

	property   :id,        Serial
	property   :delete_at, DateTime
	timestamps :at
  
	property :email,    Text
	property :password, String
	property :name,  		String
	property :phone, 		String
    
  property :loyalty,    Text, :default => ''
	property :duty,       Text, :default => ''
	property :respect,  	Text, :default => ''
  property :honor, 		  Text, :default => ''
  property :integrity, 	Text, :default => ''
  property :courage, 		Text, :default => ''
  property :service, 		Text, :default => ''
  property :importance, Text, :default => ''
  property :thoughts1, 	Text, :default => ''
  property :thoughts2, 	Text, :default => ''
  property :rolemodel, 	Text, :default => ''
  
  property :define_bullying, 	Text, :default => ''




end