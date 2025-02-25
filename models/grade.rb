class Grade < Sequel::Model
  plugin :timestamps

  many_to_one :school
  
  one_to_many :students
        
end 