class Grade
	include DataMapper::Resource

	timestamps :at, :on
	property   :deleted_at, ParanoidDateTime
	property 	 :id, 				Serial

  property :class_date,  Date
  property :presentation_id,  Integer
  property :school_id, Integer
  property :school_password, String
  
  property :college,  Integer
  property :gr12,     Integer
  property :gr11,     Integer
  property :gr10,     Integer
  property :gr9,      Integer
  property :other,    Integer
  property :unknown,  Integer
  
  belongs_to :school
  has n, :students
        
end 