class Presentation < Sequel::Model
  plugin :timestamps

  many_to_one :school, required: false
  many_to_one :recruiter, required: false
  one_to_many :students
  
end