class Report
	include DataMapper::Resource

	timestamps :at, :on
	property   :deleted_at, ParanoidDateTime
	property 	 :id, 				Serial

  property :name,           String
  property :body,           Text
  property :program,        String
  
  belongs_to :school, required: false
  belongs_to :presentation, required: false

end
