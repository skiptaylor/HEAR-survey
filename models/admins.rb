class Admin
  include DataMapper::Resource

  timestamps :at, :on
  property   :deleted_at, ParanoidDateTime
  property   :id,         Serial

  property :email,  String
  property :password, BCryptHash
  property :first_name,  String
  property :last_name,  String
  property :phone, String
  
	property :pass_reset_key,	String
	property :pass_reset_date, Date
  
end
