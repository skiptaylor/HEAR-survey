class Recruiter
  include DataMapper::Resource

  timestamps :at, :on
  property   :deleted_at, ParanoidDateTime
  property   :id,         Serial

  property :email,  String
  property :password, String
  property :rank,  String
  property :first_name,  String
  property :last_name,  String
  property :address1, String
  property :address2, String
  property :city, String
  property :state, String
  property :zip, String
  property :phone, String
  property :ssnl4, Integer
  property :reg_code, String, default: "y5qz4"
  
	property :pass_reset_key,	String
	property :pass_reset_date, Date
  
  has n, :schools
  has n, :presentations
  
end

def reg_code(number)
  rand 1000..8000
end