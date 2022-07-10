class Student
	include DataMapper::Resource

	property   :id,        Serial
	property   :delete_at, DateTime
	timestamps :at
  
	property :email,      Text
	property :first_name, String
  property :last_name,  String
  property :grade,      String
  property :phone, 		  String
  property :gender,     String
  property :ethnicity,  String
  
  property :question_1,  String
  property :question_2,  String
  property :question_3,  String
  property :question_4,  String
  property :question_5,  String
  property :question_6,  String
  property :question_7,  String
  property :question_8,  String
  property :question_9,  String
  property :question_10, String
  property :question_11, String
  property :question_12, String
  property :school_password, String
  property :presentation_id, String
  
  property :sub_code,    String
  
  property :contact_me,  String
  
  belongs_to :school, required: false
    
end 