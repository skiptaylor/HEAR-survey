class Student
	include DataMapper::Resource

	property   :id,        Serial
	property   :delete_at, DateTime
	timestamps :at
  
	property :email,        Text
	property :first_name,   String
  property :last_name,    String
  property :grade,        String
  property :phone, 		    String
  property :create_date,  Date
  property :grade_id,     Integer
  
	property :pass_reset_key,	  String
	property :pass_reset_date,  Date
  
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
  
  property :college,  Integer, default: 0
  property :gr12,  Integer, default: 0
  property :gr11,  Integer, default: 0
  property :gr10,  Integer, default: 0
  property :gr9,  Integer, default: 0
  property :other,  Integer, default: 0
  property :unknown,  Integer, default: 0
  
  property :school_password,  String
  property :presentation_id,  Integer, default: 0
  property :grade_id,  Integer, default: 0
  
  property :sub_code,    String
  property :class_date,  Date
  property :contact_me,  String
  
  belongs_to :school, required: false
  belongs_to :presentation, required: false
    
end 