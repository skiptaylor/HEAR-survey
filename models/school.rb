class School
	include DataMapper::Resource

	timestamps :at, :on
	property   :deleted_at, ParanoidDateTime
	property 	 :id, 				Serial

  property :school_id,          Integer
  property :date_modified,      String
  property :first_name,         String, default: ""
  property :last_name,          String, default: ""
  property :email,              Text,   default: ""
  property :phone,              String, default: ""
  
  property :school_name,        String, default: ""
  property :school_password,    String, default: ""
  property :address1,           String, default: ""
  property :address2,           String, default: ""
  property :city,               String, default: ""
  property :state,              String, default: ""
  property :zip,                String, default: ""
  
  property :class_date,         Date
    
  has n, :students
  has n, :presentations
  has n, :summaries
  belongs_to :recruiter, required: false
 
  before :create do |s|
    if s.school_password == ''
      zips = []
      passwords = School.all(zip: s.zip).map { |s| zips << s.school_password }
      passwords = passwords.sort{ |a, b| a <=> b }
      if passwords.count == 0
        code = '01'
      else
        code = zips.last
        code[0, 7] = ''
        code = code.to_i + 1
      end
      code = ("%02d" % code.to_i).to_s if code.to_i < 10
      s.school_password = "ph#{s.zip}#{code}"
    end
  end
  
end