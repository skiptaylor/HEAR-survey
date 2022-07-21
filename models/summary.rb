class Summary
	include DataMapper::Resource

	timestamps :at, :on
	property   :deleted_at, ParanoidDateTime
	property 	 :id, 				Serial

  property :q_1,  String
  property :q_2,  String
  property :q_3,  String
  property :q_4,  String
  property :q_5,  String
  property :q_6,  String
  property :q_7,  String
  property :q_8,  String
  property :q_9,  String
  property :q_10, String
  property :q_11, String
  property :q_12, String
  
  belongs_to :school, required: false
  belongs_to :presentation, required: false
  has n, :answers
end


class Answers
	include DataMapper::Resource

	timestamps :at, :on
	property   :deleted_at, ParanoidDateTime
	property 	 :id, 				Serial

  property :sa,  Integer, default: 0
  property :ag,  Integer, default: 0
  property :dg,  Integer, default: 0
  property :da,  Integer, default: 0
  property :na,  Integer, default: 0

  belongs_to :Summary

end