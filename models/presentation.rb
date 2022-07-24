class Presentation
	include DataMapper::Resource

	timestamps :at, :on
	property   :deleted_at, ParanoidDateTime
	property 	 :id, 				Serial

  property :class_date,  Date
  property :recruiter_id,  Integer
  property :school_id, Integer
  property :school_password, String
  
  belongs_to :school, required: false
  belongs_to :recruiter, required: false
  has n, :students
  
end